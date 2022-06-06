// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsonModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecodePassWordData _$DecodePassWordDataFromJson(Map<String, dynamic> json) =>
    DecodePassWordData(
      json['webKey'] as String,
      json['data'] as List<dynamic>,
      json['lastModifyTime'] as String?,
    );

Map<String, dynamic> _$DecodePassWordDataToJson(DecodePassWordData instance) =>
    <String, dynamic>{
      'webKey': instance.webKey,
      'data': instance.data,
      'lastModifyTime': instance.lastModifyTime,
    };
