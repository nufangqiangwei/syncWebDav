import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sync_webdav/common/Global.dart';

import '../utils/cacheFile.dart';

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
        this.errorAssetsImage = "",
      });

  @override
  final String url;

  @override
  final double scale;

  @override
  final Map<String, String>? headers;

  final bool isLocalCache;

  final String errorAssetsImage;

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
      if(key.url==""){
        if(errorAssetsImage!=""){
          var file = File(errorAssetsImage);
          bool exist = await file.exists();
          if (!exist) {
            throw AssertionError('$errorAssetsImage 文件不存在');
          }
          final Uint8List bytes = await file.readAsBytes();
          return await PaintingBinding.instance.instantiateImageCodec(bytes);
        }
        throw AssertionError("图片地址与静态文件地址均未指定");
      }
      /// 如果本地缓存过图片，直接返回图片
      if (isLocalCache == true && globalParams.cachePath != "") {
        final Uint8List? bytes = await CacheFile.getImageFromLocal(key.url);
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
        // 请求出错，展示本地的静态文件
        if(errorAssetsImage != ""){
          var file = File(errorAssetsImage);
          bool exist = await file.exists();
          if (!exist) {
              throw AssertionError('$errorAssetsImage 文件不存在');
          }
          final Uint8List bytes = await file.readAsBytes();
          return await PaintingBinding.instance.instantiateImageCodec(bytes);
        }
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
      if (isLocalCache == true && bytes.lengthInBytes != 0 && globalParams.cachePath != "") {
        CacheFile.saveImageToLocal(bytes, key.url);
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


class DefaultWebSiteIcon extends StatefulWidget{
  const DefaultWebSiteIcon({Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String url ;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  State<StatefulWidget> createState() =>_DefaultWebSiteIcon();
}
class _DefaultWebSiteIcon extends State<DefaultWebSiteIcon>{
  @override
  Widget build(BuildContext context) {
    return Image(image: MyLocalCacheNetworkImage(
      widget.url,errorAssetsImage:"assets/icons/defaultWebsite.ico",isLocalCache:true
    ));
  }

}

class DefaultUserIcon extends StatefulWidget{
  const DefaultUserIcon({Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String url ;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  State<StatefulWidget> createState() =>_DefaultUserIcon();
}
class _DefaultUserIcon extends State<DefaultUserIcon>{
  @override
  Widget build(BuildContext context) {
    return Image(image: MyLocalCacheNetworkImage(
        widget.url,errorAssetsImage:"assets/icons/defaultUser.png",isLocalCache:true
    ));
  }

}