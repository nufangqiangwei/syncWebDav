// 网站页
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sync_webdav/pages/passwordCommon/passwordUtils.dart';

import '../../common/cacheNetImage.dart';

// import '../../pkg/save/model.dart';
import '../../model/dbModel.dart';
import '../drawer.dart';
import './searchPage.dart';
import 'data.dart';

class WebSiteListPage extends StatelessWidget {
  const WebSiteListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: pageThem,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("密码管理"),
        ),
        body: _WebSiteList(),
        drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            SmartDialog.show(
              backDismiss: false,
              clickMaskDismiss: false,
                builder:(_){
                return const AddWebSitePage();
                },
            );
          },
          tooltip: '添加网站',
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


class _WebSiteList extends StatefulWidget{
  @override
  State<_WebSiteList> createState() =>_WebSiteListState();

}
class _WebSiteListState extends State<_WebSiteList>{

  late  List<WebSite> webSiteList;

  @override
  initState(){
    super.initState();
    webSiteList = PassWordDataController.webSiteList;
  }

  void searchWeb(String inputText){
    if (inputText == "") {
      webSiteList = PassWordDataController.webSiteList;
    }else{
      webSiteList =
      PassWordDataController.webSiteList.where((e) =>e.webKey.contains(inputText) || e.name.contains(inputText)).toList();
    }
    if (webSiteList.isNotEmpty) {
      PassWordDataController.switchToWebSite(webSiteList[0]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: webSiteList.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return  Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
              child: SAppBarSearch(
                onSearch:searchWeb,
              ),
            );
          }
          if (index == 1) {
            return const Padding(
              padding: EdgeInsets.all(15),
              child: SelectGroupBy(),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(
                left: 15, top: 15, right: 15, bottom: 0),
            child: WebSitePage(web: webSiteList[index - 2]),
          );
        });
  }

}

class WebSitePage extends StatefulWidget {
  const WebSitePage({required this.web, Key? key}) : super(key: key);
  final WebSite web;

  @override
  State<StatefulWidget> createState() => _WebSitePageState();
}

class _WebSitePageState extends State<WebSitePage> {
  late bool iconStatus = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: secundario,
            borderRadius: BorderRadius.circular(10.0), //圆角
          ),
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: maxWidth - 90),
                  child: InkWell(
                    onTap: () {
                      PassWordDataController.pageChange.value = 'account';
                      PassWordDataController.switchToWebSite(widget.web);
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20),
                          // child: DefaultWebSiteIcon(
                          //   url: widget.web.icon,
                          //   width: 40,
                          //   height: 40,
                          //   fit: BoxFit.fill,
                          // ),
                            child:Image(
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                              image: AssetImage('assets/icons/defaultWebsite.ico')
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: maxWidth - 170),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.web.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.web.url,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                    icon: Icon(iconStatus
                        ? Icons.favorite_outlined
                        : Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        iconStatus = !iconStatus;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SelectGroupBy extends StatefulWidget {
  const SelectGroupBy({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectGroupBy();
}

class _SelectGroupBy extends State<SelectGroupBy> {
  var select = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double window = constraints.maxWidth;
        return Padding(
          padding: EdgeInsets.only(left: window * 0.05),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    select = 1;
                  });
                },
                child: Container(
                  height: 30,
                  width: window * 0.45,
                  color: select == 1 ? acento : secundario,
                  child: const Text(
                    "网站",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    select = 2;
                  });
                },
                child: Container(
                  height: 30,
                  width: window * 0.45,
                  color: select == 2 ? acento : secundario,
                  child: const Text(
                    "自定义",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class AddWebSitePage extends StatefulWidget {
  const AddWebSitePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>_AddWebSitePage();
}

class _AddWebSitePage extends State<AddWebSitePage> {
  late String _webSiteName = '';
  late String _webSiteKey = '';

  late String nameErrorText = '';
  late String keyErrorText = '';

  String _getNameErrorText(){
    return nameErrorText;
  }
  String _getKeyErrorText(){
    return keyErrorText;
  }

  save() {
    print("啊啊啊啊");
    setState((){
      nameErrorText = "网站名重复";
    });
    for (int i = 0; i <PassWordDataController.webSiteList.length; i++) {
      if(PassWordDataController.webSiteList[i].name == _webSiteName ) {
        setState((){
          nameErrorText = "网站名重复";
        });
        return ;
      }
      if(PassWordDataController.webSiteList[i].webKey == _webSiteKey) {
        setState((){
          keyErrorText = "网站标识重复";
        });
        return ;
      }
    }
    PassWordDataController.addWebSite(WebSite('',_webSiteName,'',_webSiteKey));
    SmartDialog.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    double containerWidth = windowWidth * 0.8;
    if (containerWidth < 500) {
      containerWidth = 500;
    }
    print("组件显示宽度: $containerWidth");
    return Theme(
      data:ThemeData(
        primaryColor:Colors.green,
      ),
      child: Container(
        height: 480,
        width: 500,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

        ),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 10,
            children: [
              const Text("网站名",style: TextStyle(color: Colors.black),),
              SizedBox(
                height: 100,
                width: 400,
                child: TextField(
                  style: const TextStyle(
                    color: black,
                    fontSize: 20,
                  ),

                  decoration:  InputDecoration(
                    contentPadding:const EdgeInsets.all(10.0),
                    // hintText: "网站名称",
                    // hintStyle: const TextStyle(
                    //   color: black,
                    //   fontSize: 20,
                    // ),
                    errorText: _getNameErrorText(),
                    errorStyle:const TextStyle(
                      color: black,
                    ),
                    border: const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.blueAccent,
                        ///设置边框的粗细
                        width: 5.0,
                      ),
                    ),
                    disabledBorder:const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.yellow,
                        ///设置边框的粗细
                        width: 9.0,
                      ),
                    ),
                    ///用来配置输入框获取焦点时的颜色
                    focusedBorder:const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.green,
                        ///设置边框的粗细
                        width: 5.0,
                      ),
                    ),


                    // enabledBorder:OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(20.0),
                    //     borderSide: const BorderSide(
                    //         color: Colors.blue,
                    //         width: 5,
                    //     ),
                    // ),
                    // focusedBorder:OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(20),
                    //     borderSide:const BorderSide(
                    //       color: Colors.orange,
                    //       width: 5,
                    //     ),
                    //     gapPadding: 20, // 设置 labelText 与边框的间距
                    // ),

                  ),

                  onChanged: (String value) {
                    _webSiteName = value;
                  },
                ),
              ),
              const Text("网站标识",style: TextStyle(color: Colors.black),),
              SizedBox(
                height: 80,
                width: 400,
                child: TextField(
                  style: const TextStyle(
                    color: black,
                    fontSize: 20,
                  ),
                  decoration:  InputDecoration(
                    hintText: "标识",
                    hintStyle:const TextStyle(
                      color: black,
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                    errorText: _getKeyErrorText(),
                    errorStyle:const TextStyle(
                      color: black,
                    ),
                  ),
                  onChanged: (String value) {
                    _webSiteKey = value;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: save,
                child: const Text('保存'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
