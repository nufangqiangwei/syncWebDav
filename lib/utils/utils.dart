import 'dart:math';

getRandomPassword(int passwordLength) {
  final _random = Random();
  const _availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#%^&*';
  final randomString = List.generate(passwordLength,
          (index) => _availableChars[_random.nextInt(_availableChars.length)])
      .join();
  return randomString;
}

DifferenceData<E> differenceList<E>(List<E> left, List<E> right,
    {String Function(E data)? func}) {
  List<E> leftResult = [];
  List<E> rightResult = [];
  List<E> joinResult = [];
  List<String> leftKey=[];
  List<String> rightKey=[];
  for (final i in left){
    if (func != null){
      leftKey.add(func(i));
    }else{
      leftKey.add(i.toString());
    }
  }

  for(final i in right) {
    final String key;
    if (func != null) {
      key = func(i);
    }else{
      key = i.toString();
    }
    rightKey.add(key);
    if (!leftKey.contains(key)){
      leftResult.add(i);
    }else{
      joinResult.add(i);
    }
  }
  for (var i=0;i<leftKey.length;i++){
    if (!rightKey.contains(leftKey[i])){
      rightResult.add(left[i]);
    }
  }
  return DifferenceData<E>(leftResult,rightResult,joinResult);
}

class DifferenceData<E> {
  DifferenceData(this.left, this.right,this.joint);

  List<E> left;
  List<E> right;
  List<E> joint;
}
