
import 'package:path/path.dart' as path;

void main() {
  var newPath = path.join('/Users/shailen', '/dart/projects');
  print(newPath);
  String name = "package:pathpathdart";
  String extensionName = name.split('/').last.split('.').last;
  print(extensionName);
}



