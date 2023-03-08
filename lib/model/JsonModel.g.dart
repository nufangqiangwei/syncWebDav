// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsonModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountData _$AccountDataFromJson(Map<String, dynamic> json) => AccountData(
      json['userName'] as String,
      json['password'] as String,
      lastUsePassword: json['lastUsePassword'] as String? ?? '',
      lastModifyTime: json['lastModifyTime'] as int? ?? 0,
    );

Map<String, dynamic> _$AccountDataToJson(AccountData instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'lastUsePassword': instance.lastUsePassword,
      'lastModifyTime': instance.lastModifyTime,
    };

ServerGetPasswordDataResponse _$ServerGetPasswordDataResponseFromJson(
        Map<String, dynamic> json) =>
    ServerGetPasswordDataResponse(
      json['webKey'] as String,
      json['webData'] as String,
    );

Map<String, dynamic> _$ServerGetPasswordDataResponseToJson(
        ServerGetPasswordDataResponse instance) =>
    <String, dynamic>{
      'webKey': instance.webKey,
      'webData': instance.webData,
    };
