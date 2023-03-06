// 网站页
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/pages/passwordCommon/passwordUtils.dart';

import '../../common/Global.dart';
import '../../pkg/save/model.dart';
import '../drawer.dart';
import './searchPage.dart';

class WebSiteListPage extends StatefulWidget {
  const WebSiteListPage({Key? key, required this.touchFunc, required this.blackPage}) : super(key: key);
  final Function(WebSite) touchFunc;
  final Function(String?) blackPage;
  @override
  State<StatefulWidget> createState() => _PppPasswordPage();
}

class _PppPasswordPage extends State<WebSiteListPage> {
  @override
  Widget build(BuildContext context) {
    List<WebSite> webSiteList = Provider.of<GlobalParams>(context).webSiteList;
    return Theme(
      data: pageThem,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("密码管理"),
        ),
        body: ListView.builder(
            itemCount: webSiteList.length + 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return const  Padding(
                  padding:  EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: SAppBarSearch(),
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
                child: WebSitePage(
                    web: webSiteList[index - 2], touchFunc: widget.touchFunc),
              );
            }),
        drawer: const MyDrawer(),
      ),
    );
  }
}

class WebSitePage extends StatefulWidget {
  const WebSitePage({required this.web, required this.touchFunc, Key? key})
      : super(key: key);
  final WebSite web;
  final Function(WebSite) touchFunc;

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
                      widget.touchFunc(widget.web);
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FadeInImage.assetNetwork(
                            width: 40,
                            height: 40,
                            fit: BoxFit.fill,
                            placeholder: "assets/icons/google.ico",
                            image: "assets/icons/defaultWebsite.ico",
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/icons/defaultWebsite.ico",
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                              );
                            },
                          ),
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