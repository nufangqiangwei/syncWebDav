// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsonModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountData _$PassWordDataFromJson(Map<String, dynamic> json) => AccountData(
      json['userName'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$PassWordDataToJson(AccountData instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
    };

DecodePassWordData _$DecodePassWordDataFromJson(Map<String, dynamic> json) =>
    DecodePassWordData(
      json['webKey'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => AccountData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lastModifyTime'] as String?,
    );

Map<String, dynamic> _$DecodePassWordDataToJson(DecodePassWordData instance) =>
    <String, dynamic>{
      'webKey': instance.webKey,
      'data': instance.data,
      'lastModifyTime': instance.lastModifyTime,
    };

AccountMark _$AccountMarkFromJson(Map<String, dynamic> json) => AccountMark(
      json['keyName'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$AccountMarkToJson(AccountMark instance) =>
    <String, dynamic>{
      'keyName': instance.keyName,
      'value': instance.value,
    };
