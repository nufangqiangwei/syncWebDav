


void main() {
  List<dynamic> data=[1,2,3,4,5];
  data is List<int>;
  for(var index=0 ; index<data.length;index++) {
    peintData(data[index]);
  }

  print("转换成功");
}



peintData(int data){
  print(data);
}