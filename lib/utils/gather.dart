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