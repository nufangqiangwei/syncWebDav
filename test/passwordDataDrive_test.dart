import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/pages/passwordCommon/data.dart';
import 'package:sync_webdav/pkg/save/client.dart';
import 'package:sync_webdav/utils/log.dart';
import 'package:sync_webdav/utils/syncData.dart';
import 'package:sync_webdav/utils/utils.dart';

initApp() async {
  await initLog();
  await DB.getInstance().init();
  await globalParams.initAppConfig();
  print("初始化完成");
}

/*

选择的账号信息：用户名：测试账号 ,密码：o4e6ZrYJ8tJIBA^U
选择的账号信息：用户名：测试账号 ,密码：Zt*7u@PKgZ@JUKF#

*/
Future<void> main() async {
  await initApp();
  // await testModifyPassword();
  // await syncPasswordVersion();
  await selectWebSite(0);
  print("选择的账号信息：用户名：${PassWordDataController.selectAccountData.userName} ,密码：${PassWordDataController.selectAccountData.password}");
  await testModifyPassword();
  print("选择的账号信息：用户名：${PassWordDataController.selectAccountData.userName} ,密码：${PassWordDataController.selectAccountData.password}");
  await selectWebSite(3);
  print("选择的账号信息：用户名：${PassWordDataController.selectAccountData.userName} ,密码：${PassWordDataController.selectAccountData.password}");
  await testModifyPassword();
  print("选择的账号信息：用户名：${PassWordDataController.selectAccountData.userName} ,密码：${PassWordDataController.selectAccountData.password}");

}

selectWebSite(int index) async {
  print(PassWordDataController.webSiteList[index].name);
  await PassWordDataController.switchToWebSite(
      PassWordDataController.webSiteList[index]);
}


testModifyPassword() async {
  PassWordDataController.setSelectAccountUserName = '测试账号';
  PassWordDataController.setSelectAccountPassword = getRandomPassword(16);
  await PassWordDataController.saveAccount();
  print("保存完成");
}