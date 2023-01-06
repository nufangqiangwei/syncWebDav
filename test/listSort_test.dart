void main() {
  dynamic data;
  List<Map<String, String>> x = [];
  data = x;
  data as List<Map<String, String>>;
  for (var i = 0; i < data.length; i++) {
    print(data[i]);
  }
  print("输出完成");
  dynamic str = 123;
  if (str is String) {
    print('是string类型');
  } else if (str is int) {
    print('int');
  } else {
    print('其他类型');
  }
}
