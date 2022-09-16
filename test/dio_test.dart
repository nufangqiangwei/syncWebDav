import 'package:sync_webdav/Net/myServer.dart';

Future<void> main() async{
  var response = await getWebSiteList();
  print(response[0].toMap());

}