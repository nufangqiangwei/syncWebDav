import 'package:flutter_test/flutter_test.dart';
import 'package:sync_webdav/model/model.dart';

Future<void> main() async {
  print(await Password().select().toList());
}
