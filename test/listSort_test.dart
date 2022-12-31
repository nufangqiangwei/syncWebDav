import 'package:path/path.dart' as path;
import 'package:sync_webdav/utils/utils.dart';

List<int> left = [1, 2, 3, 4, 5, 6, 7];
List<int> right = [3, 6, 8, 2, 6];


void main() {
  print(path.join('/data/user/0/com.example.sync_webdav/cache', "app.log"));
  var result = differenceList<int>(left,right);
  print(result.left);
  print(result.right);
  print(result.joint);
}
