import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// The dart:io implementation of [image_provider.NetworkImage].
@immutable
class MyLocalCacheNetworkImage extends ImageProvider<NetworkImage> implements NetworkImage {
  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments [url] and [scale] must not be null.
  const MyLocalCacheNetworkImage(
      this.url, {
        this.scale = 1.0,
        this.headers,
        this.isLocalCache = false,
      });

  @override
  final String url;

  @override
  final double scale;

  @override
  final Map<String, String>? headers;

  final bool isLocalCache;

  @override
  Future<NetworkImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<NetworkImage>(this);
  }

  @override
  ImageStreamCompleter load(NetworkImage key, DecoderCallback decode) {
    // Ownership of this controller is handed off to [_loadAsync]; it is that
    // method's responsibility to close the controller's stream when the image
    // has been loaded or an error is thrown.
    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();

    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, chunkEvents, decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      debugLabel: key.url,
      informationCollector: () {
        return <DiagnosticsNode>[
          DiagnosticsProperty<ImageProvider>('Image provider', this),
          DiagnosticsProperty<NetworkImage>('Image key', key),
        ];
      },
    );
  }

  // Do not access this field directly; use [_httpClient] instead.
  // We set `autoUncompress` to false to ensure that we can trust the value of
  // the `Content-Length` HTTP header. We automatically uncompress the content
  // in our call to [consolidateHttpClientResponseBytes].
  static final HttpClient _sharedHttpClient = HttpClient()..autoUncompress = false;

  static HttpClient get _httpClient {
    HttpClient client = _sharedHttpClient;
    assert(() {
      if (debugNetworkImageHttpClientProvider != null) client = debugNetworkImageHttpClientProvider!();
      return true;
    }());
    return client;
  }

  Future<ui.Codec> _loadAsync(
      NetworkImage key,
      StreamController<ImageChunkEvent> chunkEvents,
      DecoderCallback decode,
      ) async {
    try {
      assert(key == this);

      /// 如果本地缓存过图片，直接返回图片
      if (isLocalCache == true) {
        final Uint8List? bytes = await _getImageFromLocal(key.url);
        if (bytes != null && bytes.lengthInBytes != 0) {
          return await PaintingBinding.instance.instantiateImageCodec(bytes);
        }
      }

      final Uri resolved = Uri.base.resolve(key.url);

      final HttpClientRequest request = await _httpClient.getUrl(resolved);

      headers?.forEach((String name, String value) {
        request.headers.add(name, value);
      });
      final HttpClientResponse response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        // The network may be only temporarily unavailable, or the file will be
        // added on the server later. Avoid having future calls to resolve
        // fail to check the network again.
        throw NetworkImageLoadException(statusCode: response.statusCode, uri: resolved);
      }

      final Uint8List bytes = await consolidateHttpClientResponseBytes(
        response,
        onBytesReceived: (int cumulative, int? total) {
          chunkEvents.add(ImageChunkEvent(
            cumulativeBytesLoaded: cumulative,
            expectedTotalBytes: total,
          ));
        },
      );

      /// 网络请求结束后，将图片缓存到本地
      if (isLocalCache == true && bytes.lengthInBytes != 0) {
        _saveImageToLocal(bytes, key.url);
      }

      if (bytes.lengthInBytes == 0) throw Exception('NetworkImage is an empty file: $resolved');

      return decode(bytes);
    } catch (e) {
      // Depending on where the exception was thrown, the image cache may not
      // have had a chance to track the key in the cache at all.
      // Schedule a microtask to give the cache a chance to add the key.
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      chunkEvents.close();
    }
  }

  /// 图片路径通过MD5处理，然后缓存到本地
  void _saveImageToLocal(Uint8List mUInt8List, String name) async {
    String path = await _getCachePathString(name);
    var file = File(path);
    bool exist = await file.exists();
    if (!exist) {
      File(path).writeAsBytesSync(mUInt8List);
    }
  }

  /// 从本地拿图片
  Future<Uint8List?> _getImageFromLocal(String name) async {
    String path = await _getCachePathString(name);
    var file = File(path);
    bool exist = await file.exists();
    if (exist) {
      final Uint8List bytes = await file.readAsBytes();
      return bytes;
    }
    return null;
  }

  /// 获取图片的缓存路径并创建
  Future<String> _getCachePathString(String name) async {
    // 获取图片的名称
    String filePathFileName = md5.convert(convert.utf8.encode(name)).toString();
    String extensionName = name.split('/').last.split('.').last;

    // print('图片url:$name');
    // print('filePathFileName:$filePathFileName');
    // print('extensionName:$extensionName');

    // 生成、获取结果存储路径
    final tempDic = await getTemporaryDirectory();
    print(tempDic.path);
    Directory directory = Directory(tempDic.path + '/CacheImage/');
    bool isFoldExist = await directory.exists();
    if (!isFoldExist) {
      await directory.create();
    }
    return directory.path + filePathFileName + '.$extensionName';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is NetworkImage && other.url == url && other.scale == scale;
  }

  @override
  int get hashCode => ui.hashValues(url, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'NetworkImage')}("$url", scale: $scale)';
}




