import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/common/passwordUtils.dart';
import 'package:sync_webdav/model/JsonModel.dart';
import 'package:sync_webdav/model/class.dart';
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
  WebSiteAccountData detailData = WebSiteAccountData();

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
            child: WebSiteListPage(touchFunc: onTouchWebSite,blackPage:blackPage),
          ),
          SizedBox(
            width: showPageNumber[1],
            child: AccountListPage(
              web: detailData.webSite,
              accountData: detailData,
              touchFunc: onTouchAccount,
              blackPage: blackPage,
            ),
          ),
          SizedBox(
            width: showPageNumber[2],
            child: PasswordDetailPage(
              blackPage: blackPage,
              detailData: detailData,
              maxWidth: showPageNumber[2],
            ),
          ),
        ],
      );
    }

    switch (page) {
      case 'webSite':
        {
          if (showPageNumber.length == 2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: showPageNumber[0],
                  child: WebSiteListPage(touchFunc: onTouchWebSite,blackPage:blackPage),
                ),
                SizedBox(
                  width: showPageNumber[1],
                  child: AccountListPage(
                    web: detailData.webSite,
                    accountData: detailData,
                    touchFunc: onTouchAccount,
                    blackPage: blackPage,
                  ),
                )
              ],
            );
          }
          return WebSiteListPage(touchFunc: onTouchWebSite,blackPage:blackPage);
        }
      case 'account':
        {
          if (showPageNumber.length == 2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: showPageNumber[0],
                  child: WebSiteListPage(touchFunc: onTouchWebSite,blackPage:blackPage),
                ),
                SizedBox(
                  width: showPageNumber[1],
                  child: AccountListPage(
                    web: detailData.webSite,
                    accountData: detailData,
                    touchFunc: onTouchAccount,
                    blackPage: blackPage,
                  ),
                )
              ],
            );
          }
          return AccountListPage(
            web: detailData.webSite,
            accountData: detailData,
            touchFunc: onTouchAccount,
            blackPage: blackPage,
          );
        }
      case 'detail':
        {
          if (showPageNumber.length == 2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: showPageNumber[0],
                  child: AccountListPage(
                    web: detailData.webSite,
                    accountData: detailData,
                    touchFunc: onTouchAccount,
                    blackPage: blackPage,
                  ),
                ),
                // PasswordDetailPage(
                //   blackPage: blackPage,
                //   detailData: detailData,
                //   maxWidth: showPageNumber[1],
                // )
                SizedBox(
                  width: showPageNumber[1],
                  child: PasswordDetailPage(
                    blackPage: blackPage,
                    detailData: detailData,
                    maxWidth: showPageNumber[1],
                  ),
                )
              ],
            );
          }
          return PasswordDetailPage(
            blackPage: blackPage,
            detailData: detailData,
          );
        }
      default:
        {
          return WebSiteListPage(touchFunc: onTouchWebSite,blackPage:blackPage);
        }
    }
  }

  blackPage(String? status) {
    if (status != null) {
      setState(() {
        page = status;
      });
      return false;
    }
    print("推出$page");
    switch (page) {
      case 'webSite':
        {
          return true;
        }
      case 'account':
        {
          setState(() {
            page = 'webSite';
          });
          return false;
        }
      case 'detail':
        {
          setState(() {
            page = 'account';
          });
          return false;
        }
      default:
        {
          return false;
        }
    }
  }

  onTouchWebSite(WebSite web) async {
    await selectWebSite(web);
    setState(() {
      page = 'account';
    });
  }

  onTouchAccount(AccountData account, int index) {
    detailData.selectAccount = account;
    detailData.selectIndex = index;
    setState(() {
      page = 'detail';
    });
  }

  selectWebSite(WebSite web) async {
    detailData.webSite = web;
    detailData.webSiteData =
        // await Password().select().webKey.equals(web.webKey).toSingleOrDefault();
        await Store()
            .select([PassWordModel.webKey.equal(web.webKey)])
            .from(PassWordModel())
            .getModel() as PassWord;
    detailData.decodeData = await decodePassword(detailData.webSiteData);
  }

  @override
  Widget build(BuildContext context) {
    // 当一次需要展示多个页面的时候，自动选择第一个站点展示。
    if (detailData.webSite.webKey == "" &&
        Provider.of<GlobalParams>(context).webSiteList.isNotEmpty) {
      selectWebSite(Provider.of<GlobalParams>(context).webSiteList[0]);
    }
    return WillPopScope(
      child: showPage(context),
      onWillPop: () async {
        return blackPage(null);
      },
    );
  }
}