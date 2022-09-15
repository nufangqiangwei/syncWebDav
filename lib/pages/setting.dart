import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sync_webdav/Net/myServer.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/common/encryption.dart';
import 'package:sync_webdav/model/model.dart';
import 'package:sync_webdav/utils/components.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:group_button/group_button.dart';
import 'package:sync_webdav/utils/gather.dart';
import 'dart:io';

import 'package:sync_webdav/utils/modifyData.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  Widget buildSettingsList() {
    return SettingsList(
      platform: DevicePlatform.iOS,
      sections: [
        SettingsSection(
          title: const Text('站点配置'),
          tiles: [
            SettingsTile(
              leading: const Icon(Icons.language),
              title: const Text('用户信息'),
              trailing: const Icon(Icons.chevron_right),
              onPressed: (context) {
                Navigator.pushNamed(context, "/userSetting");
              },
            ),
            SettingsTile(
              leading: const Icon(Icons.cloud_queue),
              title: const Text('网站配置'),
              trailing: const Icon(Icons.chevron_right),
              onPressed: (context) {
                Navigator.pushNamed(context, "/webSetting");
              },
            ),
          ],
        ),
        SettingsSection(
          title: Text('Account'),
          tiles: [
            SettingsTile(
                title: Text('Phone number'), leading: Icon(Icons.phone)),
            SettingsTile(title: Text('Email'), leading: Icon(Icons.email)),
            SettingsTile(
                title: Text('Sign out'), leading: Icon(Icons.exit_to_app)),
          ],
        ),
        SettingsSection(
          title: Text('Security'),
          tiles: [
            SettingsTile.switchTile(
              title: Text('Lock app in background'),
              leading: Icon(Icons.phonelink_lock),
              onToggle: (bool value) {
                setState(() {
                  lockInBackground = value;
                  notificationsEnabled = value;
                });
              },
              initialValue: lockInBackground,
            ),
            SettingsTile.switchTile(
              title: Text('Use fingerprint'),
              leading: Icon(Icons.fingerprint),
              onToggle: (bool value) {},
              initialValue: false,
            ),
            SettingsTile.switchTile(
              title: Text('Change password'),
              leading: Icon(Icons.lock),
              initialValue: true,
              onToggle: (bool value) {},
            ),
            SettingsTile.switchTile(
              title: Text('Enable Notifications'),
              enabled: notificationsEnabled,
              leading: Icon(Icons.notifications_active),
              initialValue: true,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Misc'),
          tiles: [
            SettingsTile(
                title: const Text('Terms of Service'),
                leading: const Icon(Icons.description)),
            SettingsTile(
                title: const Text('Open source licenses'),
                leading: Icon(Icons.collections_bookmark)),
          ],
        ),
        CustomSettingsSection(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 8),
                child: Image.asset(
                  'assets/images/settings.png',
                  height: 50,
                  width: 50,
                  color: const Color(0xFF777777),
                ),
              ),
              const Text(
                'Version: 2.4.0 (287)',
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设置页面"),
      ),
      body: buildSettingsList(),
    );
  }
}

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  final TextEditingController pubController =
      TextEditingController(text: globalParams.publicKeyStr);
  final TextEditingController priController =
      TextEditingController(text: globalParams.privateKeyStr);

  final FocusNode _pubFocusNode = FocusNode();
  final FocusNode _priFocusNode = FocusNode();

  final GlobalKey _pubGlobalKey = GlobalKey();
  final GlobalKey _priGlobalKey = GlobalKey();

  bool _showPubPopupMenuView = false;
  bool _showPriPopupMenuView = false;

  Map<String,BuildContext>dialogContext={};


  @override
  void initState() {
    _pubFocusNode.addListener(() {
      _pubFocusNode.unfocus();
      if (!_pubFocusNode.hasFocus && !_showPubPopupMenuView) {
        RenderBox? box = _pubGlobalKey.currentContext?.findRenderObject() as RenderBox?;
        RelativeRect popupMenuPosition;
        if (box!=null){
          Offset boxInitCoordinate = box.localToGlobal(Offset.zero);
           popupMenuPosition = RelativeRect.fromLTRB(
              boxInitCoordinate.dx+(box.size.width/2),
              boxInitCoordinate.dy+(box.size.height/2),
              boxInitCoordinate.dx+(box.size.width/2)+50,
              boxInitCoordinate.dy+(box.size.height/2)+50,
          );
        }else{
           popupMenuPosition = const RelativeRect.fromLTRB(0, 0, 0, 0);
        }
        _showPubPopupMenuView = true;
        popupMenuView(pubController, _showPubPopupMenuView,popupMenuPosition);
      }
    });
    _priFocusNode.addListener(() {
      _priFocusNode.unfocus();
      if (!_priFocusNode.hasFocus && !_showPriPopupMenuView) {
        RenderBox? box = _priGlobalKey.currentContext?.findRenderObject() as RenderBox?;
        RelativeRect popupMenuPosition;
        if (box!=null){
          Offset boxInitCoordinate = box.localToGlobal(Offset.zero);
          popupMenuPosition = RelativeRect.fromLTRB(
            boxInitCoordinate.dx+(box.size.width/2),
            boxInitCoordinate.dy+(box.size.height/2),
            boxInitCoordinate.dx+(box.size.width/2)+50,
            boxInitCoordinate.dy+(box.size.height/2)+50,
          );
        }else{
          popupMenuPosition = const RelativeRect.fromLTRB(0, 0, 0, 0);
        }
        _showPriPopupMenuView = true;
        popupMenuView(priController, _showPriPopupMenuView,popupMenuPosition);
      }
    });
    super.initState();
  }

  @override
  dispose() {
    _pubFocusNode.dispose();
    _priFocusNode.dispose();
    super.dispose();
  }

  popupMenuView(TextEditingController textController, bool isShow,RelativeRect popupMenuPosition) async {
    if (!isShow) return;
    showMenu<String>(
      // color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      position: popupMenuPosition,
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: '复制',
          child: Text('复制'),
        ),
        const PopupMenuItem<String>(
          value: '粘贴',
          child: Text('粘贴'),
        ),
      ],
    ).then<void>((String? selectValue) async {
      if (selectValue == "复制") {
        Clipboard.setData(ClipboardData(text: textController.text));
      } else if (selectValue == "粘贴") {
        ClipboardData? a = await Clipboard.getData(Clipboard.kTextPlain);
        if (a != null && a.text != null) {
          textController.text = a.text!;
        }
      }
      _showPubPopupMenuView = false;
      _showPriPopupMenuView = false;
    });
  }

  // 验证输入的密钥是否正确
  Future<bool> examineKey() async {
    RsaEncrypt rsa = RsaEncrypt.initKey(pubController.text, priController.text);
    String baseStr = globalParams.encryptStr;
    if(baseStr==''){
      baseStr=getRandomPassword(10);
    }
    String str = rsa.decodeString(rsa.encodeString(baseStr));
    print(str);
    print(baseStr);
    return str == "baseStr";
  }

  modifyKey() async {
    bool? status = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("提示"),
          content: const Text("修改密钥会导致重新加密整个数据库，是否继续?"),
          actions: <Widget>[
            TextButton(
              child: const Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            TextButton(
              child: const Text("确定"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    if (status == null) {
      // 取消操作
      return;
    }
    // 准备替换密钥
    showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示"),
            content: const Text("修改密钥需要等待一段时间，请不要退出app。退出app可能会导致数据库损坏无法读取数据。"),
            actions: <Widget>[
              TextButton(
                child: const Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        }) ;
    // Future.delayed(const Duration(seconds: 5),(){Navigator.pop(hiltContext);});
    // 校验密钥是否正确
    if (!await examineKey()) {
      // 关闭之前的弹窗

      return;
    }

    // todo 替换 password 表中的数据
  }

  String butterText() {
    if (Provider.of<GlobalParams>(context).userId == -1) {
      return "登录";
    }
    return "注销";
  }

  Function() getLoginCallback() {
    if (Provider.of<GlobalParams>(context).userId == -1) {
      return logoutServer;
    }
    return loginDatabaseWebSite;
  }

  logoutServer() async {
    globalParams.clearUserInfo();
  }

  loginDatabaseWebSite() async {
    if (globalParams.userId != -1) {
      return promptDialog(context, "当前已登录");
    }
    if (globalParams.publicKeyStr == "") {
      promptDialog(context, "请先添加密钥，并保存。");
      return;
    }
    await register(globalParams.publicKeyStr, globalParams.encryptStr);
    promptDialog(context, "登录成功");
  }

  Future<String> selectFile() async {
    // print('getTemporaryDirectory ：${(await getTemporaryDirectory()).path}');
    // print('getApplicationSupportDirectory ：${(await getApplicationSupportDirectory()).path}');
    // print('getApplicationDocumentsDirectory ：${(await getApplicationDocumentsDirectory()).path}');
    // print('getExternalStorageDirectory ：${await getExternalStorageDirectory()}');
    // print('getExternalCacheDirectories ：${await getExternalCacheDirectories()}');
    // print("getExternalStorageDirectories ：s ${await getExternalStorageDirectories()}");
    Directory? directory;
    directory = Directory('/storage/emulated/0/Download');
    if (kDebugMode || !await directory.exists()) {
      directory = await getExternalStorageDirectory();
    }
    if (directory == null) return "";
    String? path = await FilesystemPicker.open(
      title: 'Open file',
      context: context,
      rootDirectory: directory,
      fsType: FilesystemType.file,
      allowedExtensions: ['.txt', '.pem'],
      fileTileSelectMode: FileTileSelectMode.wholeTile,
    );
    return path!;
  }

  loadPubKey() async {
    String filePath = await selectFile();
    if (filePath == "") return;
    File file = File(filePath);
    if (!(await file.exists())) return;
    String data = file.readAsStringSync();
    if (!data.contains("PUBLIC")) {
      AlertDialog(
        title: const Text("提示"),
        content: const Text("公钥不正确"),
        actions: <Widget>[
          TextButton(
            child: const Text("确定"),
            onPressed: () {},
          ),
        ],
      );
      return;
    }
    pubController.text = data;
    return;
  }

  loadPriKey() async {
    String filePath = await selectFile();
    if (filePath == "") return;
    File file = File(filePath);
    if (!(await file.exists())) return;
    String data = file.readAsStringSync();
    if (!data.contains("PRIVATE")) {
      AlertDialog(
        title: const Text("提示"),
        content: const Text("公钥不正确"),
        actions: <Widget>[
          TextButton(
            child: const Text("确定"),
            onPressed: () {},
          ),
        ],
      );
      return;
    }
    priController.text = data;
    return;
  }

  String showUserId() {
    int userId = Provider.of<GlobalParams>(context).userId;
    if (userId == -1) {
      return '';
    }
    return userId.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("用户信息"),
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
            title: const Text('用户信息'),
            tiles: [
              SettingsTile(
                leading: const Icon(Icons.account_circle_sharp),
                title: const Text('用户ID'),
                trailing: Text(showUserId()),
              ),
              SettingsTile(
                leading: const Icon(Icons.vpn_key),
                title: const Text('加密字符串'),
                trailing: Text(Provider.of<GlobalParams>(context).encryptStr),
              ),
            ],
          ),
          SettingsSection(
            title: Row(
              children: [
                const Text('用户密钥-公钥'),
                TextButton(
                    onPressed:loadPubKey,
                    child: const Text("选择文件"))
              ],
            ),
            tiles: [
              SettingsTile(
                title: TextField(
                  key:_pubGlobalKey,
                  controller: pubController,
                  focusNode: _pubFocusNode,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  minLines: 5,
                  maxLines: 15,
                  readOnly:true,
                ),
              ),
            ],
          ),
          SettingsSection(
            title: Row(
              children: [
                const Text('用户密钥-私钥'),
                TextButton(
                    onPressed: loadPriKey,
                    child: const Text("选择文件"))
              ],
            ),
            tiles: [
              SettingsTile(
                title: TextField(
                  key:_priGlobalKey,
                  controller: priController,
                  focusNode: _priFocusNode,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  minLines: 5,
                  maxLines: 15,
                  readOnly:true,
                ),
              )
            ],
          ),
          CustomSettingsSection(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: modifyKey,
                    child: const Text('保存密钥'),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.green,
                      shape: const StadiumBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: getLoginCallback(),
                    child: Text(butterText()),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.green,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomSettingsSection(
            child: Image.asset(
              'assets/images/settings.png',
              height: 50,
              width: 50,
              color: const Color(0xFF777777),
            ),
          )
        ],
      ),
    );
  }
}

class DatabaseSettingPage extends StatefulWidget {
  const DatabaseSettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DatabaseSettingPageState();
}

class _DatabaseSettingPageState extends State<DatabaseSettingPage> {
  synchronizeWebSite() async {
    List<WebSite> webSiteList = await getWebSiteList();
    // List<WebSite> saveList = globalParams.webSiteList;
    // webSiteList.sort((a,b)=>(a.id??0) - (b.id??0));
    //
    // List<WebSite> result =[];
    // for (var i=0;i<webSiteList.length;i++){
    //   var a = webSiteList[i];
    //   var b=WebSite();
    //   if (i<saveList.length) {
    //     WebSite b = saveList[i];
    //   }
    //   if (a.name != b.name || a.webKey != b.webKey||a.icon!=b.icon) {
    //     result.add(a);
    //   }
    // }
    print(await WebSite().upsertAll(webSiteList));
    globalParams.refreshWebSiteList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示"),
            content: const Text("同步完成"),
            actions: <Widget>[
              TextButton(
                child: const Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  selectFolder(BuildContext context) async {
    final Directory? rootPath = await getExternalStorageDirectory();
    if (rootPath == null) {
      return;
    }
    String? path = await FilesystemPicker.open(
      title: 'Open file',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.file,
      folderIconColor: Colors.teal,
      allowedExtensions: ['.json'],
      fileTileSelectMode: FileTileSelectMode.wholeTile,
    );
    return path;
  }

  outPassWordData(BuildContext context) async {
    String path = selectFolder(context);
    List<Password> localData =
        await Password().select(getIsDeleted: false).toList();
    Map<String, String> jsonData = {};
    for (var i = 0; i < localData.length; i++) {
      jsonData[localData[i].webKey ?? ''] = localData[i].value ?? '';
    }
    String strJson = json.encode(jsonData);
    File file = File("$path/PasswordData.json");
    if (!file.existsSync()) {
      file.createSync();
    }
    await file.writeAsString(strJson);
  }

  uploadDataToServer(BuildContext context) async {
    List<String> uploadList = ["password", "notebook"];
    aa(String type) async {
      String? err = await uploadData(type);
      if (err != null) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("提示"),
                content: const Text("无法连接到服务器。"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("确定"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    }

    for (int i = 0; i < uploadList.length; i++) {
      await aa(uploadList[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("网站配置信息"),
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
            title: const Text("数据库信息"),
            tiles: [
              SettingsTile.navigation(
                title: const Text("同步站点数据"),
                onPressed: (context) {
                  synchronizeWebSite();
                },
              ),
              // SettingsTile(
              //   title: const UserUploadSetting(),
              // ),
              SettingsTile.navigation(
                title: const Text("备份到服务器"),
                onPressed: uploadDataToServer,
              ),
              SettingsTile.navigation(
                title: const Text("同步服务器数据"),
              ),
              SettingsTile.navigation(
                title: const Text("导出到"),
                onPressed: outPassWordData,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UserUploadSetting extends StatefulWidget {
  const UserUploadSetting({Key? key}) : super(key: key);

  @override
  State<UserUploadSetting> createState() => _UserUploadSettingView();
}

class _UserUploadSettingView extends State<UserUploadSetting> {
  final controller = GroupButtonController(
    selectedIndex: 1,
  );

  @override
  Widget build(BuildContext context) {
    // 0xffeeeeee
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        '同步设置',
        style: TextStyle(),
      ),
      const Divider(height: 0, thickness: 0.7, color: Color(0xffeeeeee)),
      GroupButton(
        isRadio: true,
        onSelected: (value, index, isSelected) =>
            print('$index button is selected,$value'),
        controller: controller,
        buttons: const ["手动", "每次修改"],
      )
    ]);
  }
}
