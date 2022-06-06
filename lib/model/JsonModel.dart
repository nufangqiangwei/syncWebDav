import 'package:json_annotation/json_annotation.dart';

import 'class.dart';


part 'JsonModel.g.dart';


///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class DecodePassWordData{
  DecodePassWordData(this.webKey, this.data, this.lastModifyTime);

  String webKey;
  List<dynamic> data;
  String? lastModifyTime;
  //不同的类使用不同的mixin即可
  factory DecodePassWordData.fromJson(Map<String, dynamic> json) => _$DecodePassWordDataFromJson(json);
  Map<String, dynamic> toJson() => _$DecodePassWordDataToJson(this);
}