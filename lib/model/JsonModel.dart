import 'package:json_annotation/json_annotation.dart';



part 'JsonModel.g.dart';

@JsonSerializable()
class AccountData{
  AccountData(this.userName,this.password);

  late String userName;
  late String password;

  factory AccountData.fromJson(Map<String, dynamic> json) => _$PassWordDataFromJson(json);
  Map<String, dynamic> toJson() => _$PassWordDataToJson(this);
}


///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class DecodePassWordData{
  DecodePassWordData(this.webKey, this.data, this.lastModifyTime);

  final String webKey;
  final List<AccountData> data;
  final String? lastModifyTime;
  //不同的类使用不同的mixin即可
  factory DecodePassWordData.fromJson(Map<String, dynamic> json) => _$DecodePassWordDataFromJson(json);
  Map<String, dynamic> toJson() => _$DecodePassWordDataToJson(this);
}

@JsonSerializable()
class AccountMark{
  AccountMark(this.keyName,this.value);

  late String keyName;
  late String value;

  factory AccountMark.fromJson(Map<String, dynamic> json) => _$AccountMarkFromJson(json);
  Map<String, dynamic> toJson() => _$AccountMarkToJson(this);
}