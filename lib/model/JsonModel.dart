import 'package:json_annotation/json_annotation.dart';

part 'JsonModel.g.dart';

@JsonSerializable()
class AccountData {
  AccountData(this.userName, this.password,
      {this.lastUsePassword = '', this.lastModifyTime = 0});

  late String userName;
  late String password;
  late String lastUsePassword;
  late int lastModifyTime;

  factory AccountData.fromJson(Map<String, dynamic> json) =>
      _$AccountDataFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDataToJson(this);
}

@JsonSerializable()
class ServerGetPasswordDataResponse {
  ServerGetPasswordDataResponse(this.webKey, this.webData);

  late String webKey;
  late String webData;

  factory ServerGetPasswordDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ServerGetPasswordDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServerGetPasswordDataResponseToJson(this);
}
