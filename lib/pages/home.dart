import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/common/utils.dart';

import 'index.dart';
import 'password.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Drawer homeDrawer() {
    return Drawer(
      // 重要的Drawer组件
      child: ListView(
        // Flutter 可滚动组件
        padding: EdgeInsets.zero, // padding为0
        children: <Widget>[
          UserAccountsDrawerHeader(
            // UserAccountsDrawerHeader 可以设置用户头像、用户名、Email 等信息，显示一个符合纸墨设计规范的 drawer header。
            // 标题
            accountName: const Text('Jack Sparrow',
                style: TextStyle(fontWeight: FontWeight.bold)),
            // 副标题
            accountEmail: const Text('xxx@gmail.com'),
            // Emails
            currentAccountPicture: const CircleAvatar(
              // 使用网络加载图像
                backgroundImage: AssetImage('assets/images/Jack Sparrow.jpg')
              // NetworkImage('assets/images/Jack Sparrow.jpg'),
            ),
            // 圆角头像
            decoration: BoxDecoration(
                color: Colors.yellow[400],
                image: DecorationImage(
                    image: const AssetImage('assets/images/Boat.jpg'),
                    fit: BoxFit.cover, // 一种图像的布局方式
                    colorFilter: ColorFilter.mode(
                        Colors.grey.shade400.withOpacity(0.6),
                        // Colors.grey[400].withOpacity(0.6),
                        BlendMode.hardLight))),
            //  BoxDecoration 用于制作背景
          ),
          // ListTile是下方的几个可点按List
          ListTile(
            leading: const Icon(
              Icons.maps_home_work_outlined, // Icon种类
              // color: Colors.black12, // Icon颜色
              // size: 22.0, // Icon大小
            ),
            title: const Text('首页'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(
              Icons.vpn_key_outlined, // Icon种类
            ),
            title: const Text('密码'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => {
              Provider.of<GlobalParams>(context,listen: false).ModifyAppBarText("密码页面"),
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PassWordPage()))
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.note_alt,
            ),
            title: const Text('笔记'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Provider.of<GlobalParams>(context,listen: false).ModifyAppBarText("记事本页面"),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings_suggest,
            ),
            title: const Text('设置'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Provider.of<GlobalParams>(context,listen: false).ModifyAppBarText("设置页面"),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("卜大爷 "),
            subtitle: const Text("010-12345678"),
            trailing: const Icon(Icons.arrow_forward_ios),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            enabled: true,
            onTap: () => print("被点击了"),
            onLongPress: () => print("被长按了"),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<GlobalParams>(context).appBarText),
      ),
      body: const PassWordPage(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      drawer: homeDrawer(),
    );
  }
}
