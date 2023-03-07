import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/common/passwordUtils.dart';
import 'package:sync_webdav/model/JsonModel.dart';
import 'package:sync_webdav/pages/passwordCommon/data.dart';
import 'package:sync_webdav/pages/passwordCommon/passwordWebListPage.dart';
import 'package:sync_webdav/pages/passwordCommon/passwordAccountListPage.dart';
import 'package:sync_webdav/pages/passwordCommon/passwordDetailPage.dart';
import 'package:sync_webdav/pkg/save/model.dart';
import 'package:sync_webdav/pkg/save/client.dart';

const double webSiteMaxWidth = 600;
const double webSiteMinWidth = 500;

const double accountMaxWidth = 400;
const double accountMinWidth = 300;

const double detailMaxWidth = 3000;
const double detailMinWidth = 700;

class PassWordPage extends StatefulWidget {
  const PassWordPage({Key? key}) : super(key: key);

  @override
  State<PassWordPage> createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> {
  late String page = 'webSite';

  @override
  initState(){
    super.initState();
    PassWordDataController.pageChange.addListener((){
      if(mounted){
        setState((){});
      }
    });
  }

  List<double> showWidth(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    if (windowWidth < (webSiteMinWidth + accountMinWidth)) {
      return [windowWidth];
    }
    if (windowWidth == (webSiteMinWidth + accountMinWidth)) {
      return [webSiteMinWidth, accountMinWidth];
    }
    if (windowWidth < (webSiteMaxWidth + accountMinWidth)) {
      return [windowWidth - accountMinWidth, accountMinWidth];
    }
    if (windowWidth == (webSiteMaxWidth + accountMinWidth)) {
      return [webSiteMaxWidth, accountMinWidth];
    }
    if (windowWidth < (webSiteMaxWidth + accountMaxWidth)) {
      return [webSiteMaxWidth, windowWidth - webSiteMaxWidth];
    }
    if (windowWidth == (webSiteMaxWidth + accountMaxWidth)) {
      return [webSiteMaxWidth, windowWidth - webSiteMaxWidth];
    }
    if (windowWidth < (webSiteMinWidth + accountMinWidth + detailMinWidth)) {
      return [windowWidth / 2, windowWidth / 2];
    }
    if (windowWidth == (webSiteMinWidth + accountMinWidth + detailMinWidth)) {
      return [webSiteMinWidth, accountMinWidth, detailMinWidth];
    }
    if (windowWidth < (webSiteMinWidth + accountMaxWidth + detailMinWidth)) {
      return [
        webSiteMinWidth,
        windowWidth - (webSiteMinWidth + detailMinWidth),
        detailMinWidth
      ];
    }
    if (windowWidth == (webSiteMinWidth + accountMaxWidth + detailMinWidth)) {
      return [webSiteMinWidth, accountMaxWidth, detailMinWidth];
    }
    if (windowWidth < (webSiteMaxWidth + accountMaxWidth + detailMinWidth)) {
      return [
        windowWidth - (accountMaxWidth + detailMinWidth),
        accountMaxWidth,
        detailMinWidth
      ];
    }
    if (windowWidth == (webSiteMaxWidth + accountMaxWidth + detailMinWidth)) {
      return [webSiteMaxWidth, accountMaxWidth, detailMinWidth];
    }
    return [
      webSiteMaxWidth,
      accountMaxWidth,
      windowWidth - (webSiteMaxWidth + accountMaxWidth)
    ];
  }

  Widget showPage(BuildContext context) {
    List<double> showPageNumber = showWidth(context);
    if (showPageNumber.length == 3) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: showPageNumber[0],
            child: const WebSiteListPage(),
          ),
          SizedBox(
            width: showPageNumber[1],
            child:const AccountListPage(),
          ),
          SizedBox(
            width: showPageNumber[2],
            child: PasswordDetailPage(
              maxWidth: showPageNumber[2],
            ),
          ),
        ],
      );
    }

    switch (PassWordDataController.pageName) {
      case 'webSite':
        {
          if (showPageNumber.length == 2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: showPageNumber[0],
                  child: const WebSiteListPage(),
                ),
                SizedBox(
                  width: showPageNumber[1],
                  child:const  AccountListPage(),
                )
              ],
            );
          }
          return const WebSiteListPage();
        }
      case 'account':
        {
          if (showPageNumber.length == 2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: showPageNumber[0],
                  child:const  WebSiteListPage(),
                ),
                SizedBox(
                  width: showPageNumber[1],
                  child: const AccountListPage(),
                )
              ],
            );
          }
          return const  AccountListPage();
        }
      case 'detail':
        {
          if (showPageNumber.length == 2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: showPageNumber[0],
                  child: const AccountListPage(),
                ),
                SizedBox(
                  width: showPageNumber[1],
                  child: PasswordDetailPage(
                    maxWidth: showPageNumber[1],
                  ),
                )
              ],
            );
          }
          return const PasswordDetailPage();
        }
      default:
        {
          return const WebSiteListPage();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    // todo 当一次需要展示多个页面的时候，自动选择第一个站点展示。
    // if (detailData.webSite.webKey == "" &&
    //     Provider.of<GlobalParams>(context).webSiteList.isNotEmpty) {
    //   selectWebSite(Provider.of<GlobalParams>(context).webSiteList[0]);
    // }
    return WillPopScope(
      child: showPage(context),
      onWillPop: () async {
        return PassWordDataController.blackPage();
      },
    );
  }

  @override
  dispose(){
    super.dispose();
    PassWordDataController.pageChange.removeListener((){
      if(mounted){
        setState((){});
      }
    });
  }
}
