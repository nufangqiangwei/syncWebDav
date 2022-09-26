import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/common/passwordUtils.dart';
import 'package:sync_webdav/model/JsonModel.dart';
import 'package:sync_webdav/model/class.dart';
import 'package:sync_webdav/model/model.dart';
import 'package:sync_webdav/utils/gather.dart';
import 'package:sync_webdav/utils/modifyData.dart';

const double webSiteMaxWidth = 600;
const double webSiteMinWidth = 500;

const double accountMaxWidth = 400;
const double accountMinWidth = 300;

const double detailMaxWidth = 3000;
const double detailMinWidth = 700;

// 网站列表配色
const black = Colors.black54;
const black87 = Colors.black12;
const selectColor = Color.fromRGBO(251, 251, 251, 1);
const notSelectColor = Color.fromRGBO(161, 159, 159, 1);
const primario = Color.fromRGBO(33, 34, 38, 1);
const secundario = Color.fromRGBO(53, 54, 58, 1);
const fondo = Color.fromRGBO(161, 159, 159, 1);
const acento = Color.fromRGBO(251, 251, 251, 1);

// 详情页配色
const detailColor = Color.fromRGBO(36, 40, 80, 1);
const detailBackgroundColor = Color.fromRGBO(27, 30, 60, 1);
const inputTitleColor = Color.fromRGBO(130, 148, 165, 1);
const inputTextColor = Color.fromRGBO(254, 254, 254, 1);

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
            child: WebSiteListPage(touchFunc: onTouchWebSite),
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
                  child: WebSiteListPage(touchFunc: onTouchWebSite),
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
          return WebSiteListPage(touchFunc: onTouchWebSite);
        }
      case 'account':
        {
          if (showPageNumber.length == 2) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: showPageNumber[0],
                  child: WebSiteListPage(touchFunc: onTouchWebSite),
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
          return WebSiteListPage(touchFunc: onTouchWebSite);
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
        await Password().select().webKey.equals(web.webKey).toSingleOrDefault();
    detailData.decodeData = await decodePassword(detailData.webSiteData);
  }

  @override
  Widget build(BuildContext context) {
    if (detailData.webSite.id == null &&
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

// 网站页
class WebSiteListPage extends StatefulWidget {
  const WebSiteListPage({Key? key, required this.touchFunc}) : super(key: key);
  final Function(WebSite) touchFunc;

  @override
  State<StatefulWidget> createState() => _PppPasswordPage();
}

class _PppPasswordPage extends State<WebSiteListPage> {
  @override
  Widget build(BuildContext context) {
    List<WebSite> webSiteList = Provider.of<GlobalParams>(context).webSiteList;
    return Theme(
        data: ThemeData(
          // primaryColor: black87,
          //用于导航栏、FloatingActionButton的背景色等
          // iconTheme: const IconThemeData(color: black87),
          //用于Icon颜色
          appBarTheme: const AppBarTheme(backgroundColor: primario),
          fontFamily: 'LXGWWenKai',
          scaffoldBackgroundColor: primario,
        ),
        child: Scaffold(
            appBar: AppBar(
              title: const Text("主题测试 hello world"),
            ),
            body: ListView.builder(
                itemCount: webSiteList.length + 2,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 15, left: 15, top: 10),
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
                        web: webSiteList[index - 2],
                        touchFunc: widget.touchFunc),
                  );
                })));
  }
}

class SAppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  const SAppBarSearch({
    Key? key,
    this.borderRadius = 20,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    this.height = 40,
    this.value = '',
    this.leading,
    this.suffix,
    this.actions = const [],
    this.hintText,
    this.onTap,
    this.onClear,
    this.onCancel,
    this.onChanged,
    this.onSearch,
  }) : super(key: key);
  final double borderRadius;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;

// 输入框高度 默认40
  final double height;

// 默认值
  final String? value;

// 最前面的组件
  final Widget? leading;

// 搜索框后缀组件
  final Widget? suffix;
  final List<Widget> actions;

// 提示文字
  final String? hintText;

// 输入框点击
  final VoidCallback? onTap;

// 单独清除输入框内容
  final VoidCallback? onClear;

// 清除输入框内容并取消输入
  final VoidCallback? onCancel;

// 输入框内容改变
  final ValueChanged? onChanged;

// 点击键盘搜索
  final ValueChanged? onSearch;

  @override
  _SAppBarSearchState createState() => _SAppBarSearchState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SAppBarSearchState extends State<SAppBarSearch> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool isInput = false;

  bool get isFocus => _focusNode.hasFocus;

  bool get isTextEmpty => _controller.text.isEmpty;

  bool get isActionEmpty => widget.actions.isEmpty;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.value != null) _controller.text = widget.value!;
    // 监听输入框状态
    _focusNode.addListener(() => setState(() {}));
    // 监听输入框变化
    // 解决当外部改变输入框内容时 控件处于正确的状态中 (显示清除图标按钮和取消按钮等)
    _controller.addListener(() {
      setState(() {});
      widget.onChanged?.call(_controller.text);
    });
    super.initState();
  }

  // 清除输入框内容
  void _onClearInput() {
    _controller.clear();
    if (!isFocus) _focusNode.requestFocus();
    setState(() {});
    widget.onClear?.call();
  }

  // 取消输入框编辑
  void _onCancelInput() {
    _controller.clear();
    _focusNode.unfocus();
    setState(() {});
    widget.onCancel?.call();
  }

  Widget _suffix() {
    if (!isTextEmpty) {
      return GestureDetector(
        onTap: _onClearInput,
        child: SizedBox(
          width: widget.height,
          height: widget.height,
          child: Icon(Icons.cancel, size: 22, color: Color(0xFF999999)),
        ),
      );
    }
    return widget.suffix ?? SizedBox();
  }

  List<Widget> _actions() {
    List<Widget> list = [];
    if (isFocus || !isTextEmpty) {
      list.add(GestureDetector(
        onTap: _onCancelInput,
        child: Container(
          constraints: BoxConstraints(minWidth: 48),
          alignment: Alignment.center,
          child: Text(
            '取消',
            style: TextStyle(color: Color(0xFF666666), fontSize: 15),
          ),
        ),
      ));
    } else if (!isActionEmpty) {
      list.addAll(widget.actions);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final ModalRoute<Object?>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    const bool hasDrawer = false;
    double left = !canPop && !hasDrawer && widget.leading == null ? 15 : 0;
    double right = isActionEmpty && !isFocus && isTextEmpty ? 15 : 0;
    return Container(
      margin: EdgeInsets.only(right: right, left: left),
      height: widget.height,
      decoration: BoxDecoration(
        color: secundario,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Row(
        children: [
          SizedBox(
            width: widget.height,
            height: widget.height,
            child: const Icon(Icons.search, size: 22, color: Color(0xFF999999)),
          ),
          Expanded(
            child: TextField(
              autofocus: widget.autoFocus,
              focusNode: _focusNode,
              controller: _controller,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: widget.hintText ?? '请输入关键字',
                hintStyle: const TextStyle(fontSize: 15, color: fondo),
              ),
              style: const TextStyle(fontSize: 15, color: fondo, height: 1.3),
              textInputAction: TextInputAction.search,
              onTap: widget.onTap,
              onSubmitted: widget.onSearch,
            ),
          ),
          _suffix(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
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
// https://www.behance.net/gallery/108360683/Flight-Booking-Mobile-App/modules/620949643
// https://www.behance.net/gallery/150031519/Locki-App-Mobile?tracking_source=search_projects%7Cpassword
// https://www.behance.net/gallery/148814711/Password-Manager-Mobile-App
// https://signup.passwall.io/free

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
                          image: widget.web.icon!,
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
                          constraints: BoxConstraints(maxWidth: maxWidth - 170),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.web.name!,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.web.url!,
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
    });
  }
}

// 账号页
class AccountListPage extends StatefulWidget {
  const AccountListPage({
    Key? key,
    required this.web,
    required this.accountData,
    required this.touchFunc,
    required this.blackPage,
  }) : super(key: key);

  final WebSiteAccountData accountData;
  final Function(AccountData, int) touchFunc;
  final Function(String?) blackPage;
  final WebSite web;

  @override
  State<StatefulWidget> createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  Widget? addIcon() {
    return FloatingActionButton(
      onPressed: () {
        widget.touchFunc(AccountData('', ''), -2);
      },
      tooltip: 'Increment',
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: primario),
        fontFamily: 'LXGWWenKai',
        scaffoldBackgroundColor: primario,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              widget.blackPage(null);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("账号列表"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: FadeInImage.assetNetwork(
                width: 45,
                height: 45,
                fit: BoxFit.fill,
                placeholder: widget.web.icon!,
                image: widget.web.icon!,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/icons/defaultWebsite.ico",
                    width: 45,
                    height: 45,
                    fit: BoxFit.fill,
                  );
                },
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: widget.accountData.decodeData.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                child: SAppBarSearch(),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 15, right: 15, bottom: 0),
              child: AccountPage(
                password: widget.accountData.decodeData[index - 1],
                touchFunc: widget.touchFunc,
                index: index - 1,
              ),
            );
          },
        ),
        floatingActionButton: addIcon(),
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage(
      {required this.password,
      required this.touchFunc,
      required this.index,
      Key? key})
      : super(key: key);
  final AccountData password;
  final Function(AccountData, int) touchFunc;
  final int index;

  @override
  State<StatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
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
            InkWell(
              onTap: () {
                widget.touchFunc(widget.password, widget.index);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FadeInImage.assetNetwork(
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                      placeholder: "assets/icons/defaultUser.png",
                      image: "assets/icons/defaultUser.png",
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/icons/defaultUser.png",
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
                      constraints: const BoxConstraints(maxWidth: 360),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.password.userName,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.password.password,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 详情页
class PasswordDetailPage extends StatefulWidget {
  const PasswordDetailPage(
      {Key? key,
      required this.detailData,
      required this.blackPage,
      this.maxWidth})
      : super(key: key);
  final WebSiteAccountData detailData;
  final Function(String? status) blackPage;
  final double? maxWidth;

  @override
  State<StatefulWidget> createState() => _PasswordDetailPageState();
}

class _PasswordDetailPageState extends State<PasswordDetailPage> {
  savePassword() async {
    if (widget.detailData.selectAccount.userName == ""){
      return ;
    }
    if (widget.detailData.selectIndex == -2) {
      widget.detailData.selectIndex = widget.detailData.decodeData.length - 1;
      widget.detailData.decodeData.add(widget.detailData.selectAccount);
    } else if (widget.detailData.selectIndex == -1) {
      widget.detailData.decodeData.add(widget.detailData.selectAccount);
    } else {
      widget.detailData.decodeData[widget.detailData.selectIndex] =
          widget.detailData.selectAccount;
    }

    widget.detailData.webSiteData.isModify = true;
    widget.detailData.webSiteData.webKey = widget.detailData.webSite.webKey;
    if (widget.detailData.webSiteData.version ==null){
      widget.detailData.webSiteData.version=1;
    }else{
      widget.detailData.webSiteData.version = widget.detailData.webSiteData.version!+1;
    }

    await (await encodePassword(
            widget.detailData.webSiteData, widget.detailData.decodeData))
        .save();
    widget.detailData.selectIndex++;
    uploadData("password");
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: primario),
        fontFamily: 'LXGWWenKai',
        scaffoldBackgroundColor: detailBackgroundColor,
      ),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              savePassword();
              widget.blackPage(null);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("账号列表"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: FadeInImage.assetNetwork(
                width: 45,
                height: 45,
                fit: BoxFit.fill,
                placeholder: "assets/icons/google.ico",
                image: 'assets/icons/github.ico',
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/icons/defaultWebsite.ico",
                    width: 45,
                    height: 45,
                    fit: BoxFit.fill,
                  );
                },
              ),
            )
          ],
        ),
        body: PageBody(
          detailData: widget.detailData,
          maxWidth: widget.maxWidth,
          savePassword: savePassword,
        ),
      ),
    );
  }
}

class BackgroundCanvas extends StatelessWidget {
  const BackgroundCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        decoration: const BoxDecoration(
          color: detailColor,
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var p0 = Offset(0, size.height * 0.3);
    var p1 = Offset(size.width * 0.02, size.height * 0.6);
    var p2 = Offset(size.width * 0.5, size.height * 0.6);
    var p3 = Offset(size.width, size.height * 0.1);
    path.lineTo(p0.dx, p0.dy);
    // path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class PageBody extends StatelessWidget {
  const PageBody(
      {Key? key,
      required this.detailData,
      this.maxWidth,
      required this.savePassword})
      : super(key: key);
  final WebSiteAccountData detailData;
  final double? maxWidth;
  final Function() savePassword;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      textDirection: TextDirection.ltr,
      fit: StackFit.loose,
      children: [
        const BackgroundCanvas(),
        Positioned(
          child: ViewPage(
            detailData: detailData,
            maxWidth: maxWidth,
            savePassword: savePassword,
          ),
          left: 0,
        )
      ],
    );
  }
}

class ViewPage extends StatefulWidget {
  const ViewPage(
      {Key? key,
      required this.detailData,
      this.maxWidth,
      required this.savePassword})
      : super(key: key);
  final WebSiteAccountData detailData;
  final double? maxWidth;
  final Function() savePassword;

  @override
  State<StatefulWidget> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  double _sliderValue = 8;
  int passwordLength = 8;
  String _errorText = '';
  bool isModify = false;
  final TextEditingController passwordController = TextEditingController();

  @override
  initState() {
    if (widget.detailData.selectAccount.userName==""){
      isModify=true;
    }
    passwordController.text = widget.detailData.selectAccount.password;
    if (widget.detailData.selectAccount.password.isNotEmpty) {
      _sliderValue = widget.detailData.selectAccount.password.length.toDouble();
      passwordLength = widget.detailData.selectAccount.password.length;
    }
    super.initState();
  }

  _getErrorText() {
    return _errorText;
  }

  @override
  Widget build(BuildContext context) {
    Size windows;
    if (widget.maxWidth == null) {
      windows = MediaQuery.of(context).size;
    } else {
      windows =
          Size(widget.maxWidth ?? 700, MediaQuery.of(context).size.height);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: windows.height * 0.2, left: 10),
          child: Text(
            widget.detailData.webSite.name!,
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontSize: 45,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            "用户名：",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: inputTitleColor,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Row(
            children: [
              SizedBox(
                width: windows.width * 0.8,
                child: TextFormField(
                  style: const TextStyle(
                    color: inputTextColor,
                    fontSize: 20,
                  ),
                  // controller:TextEditingController(text: widget.detailData.data.userName),
                  initialValue: widget.detailData.selectAccount.userName,
                  decoration: const InputDecoration(
                    hintText: "用户名",
                    hintStyle: TextStyle(
                      color: inputTextColor,
                      fontSize: 20,
                    ),
                    // prefixText: "407640432",
                    // prefixStyle: TextStyle(
                    //   color: textColor,
                    //   fontSize: 20,
                    // ),
                    border: InputBorder.none,
                  ),
                  readOnly: !isModify,
                  onChanged: (String value) {
                    widget.detailData.selectAccount.userName = value;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text: widget.detailData.selectAccount.userName));
                  SmartDialog.showToast("复制成功");
                },
                icon: const Icon(Icons.content_copy),
              )
            ],
          ),
        ),
        SizedBox(
          width: windows.width,
          child: const Divider(
            height: 1.0,
            indent: 30,
            endIndent: 60.0,
            color: inputTextColor,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            "密码：",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: inputTitleColor,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, top: 10,bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(
            children: [
              SizedBox(
                width: windows.width * 0.8,
                child: TextFormField(
                  controller: passwordController,
                  style: const TextStyle(
                    color: inputTextColor,
                    fontSize: 20,
                  ),
                  // controller:TextEditingController(text: widget.detailData.data.password),
                  decoration: const InputDecoration(
                    hintText: "密码",
                    hintStyle: TextStyle(
                      color: inputTextColor,
                      fontSize: 20,
                    ),
                    // prefixText: "407640432",
                    // prefixStyle: TextStyle(
                    //   color: textColor,
                    //   fontSize: 20,
                    // ),
                    border: InputBorder.none,
                  ),
                  readOnly: !isModify,
                  onChanged: (String value) {
                    widget.detailData.selectAccount.password = value;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  if (isModify) {
                    setState(() {
                      passwordController.text =
                          getRandomPassword(passwordLength);
                      widget.detailData.selectAccount.password =
                          passwordController.text;
                    });
                  } else {
                    Clipboard.setData(
                        ClipboardData(text: passwordController.text));
                    SmartDialog.showToast("复制成功");
                  }
                },
                icon: Icon(!isModify ? Icons.content_copy : Icons.loop),
              )
            ],
          ),
        ),
        SizedBox(
          width: windows.width,
          child: const Divider(
            height: 1.0,
            indent: 30,
            endIndent: 60.0,
            color: inputTextColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: <Widget>[
              const Text(
                '长度',
                style: TextStyle(
                  color: inputTextColor,
                ),
              ),
              Slider(
                value: _sliderValue,
                onChanged: (data) {
                  setState(() {
                    _sliderValue = data;
                    passwordLength = data.toInt();
                    _errorText = '';
                  });
                },
                onChangeStart: (data) {},
                onChangeEnd: (data) {},
                min: 8.0,
                max: 32.0,
                divisions: 32,
                label: '$passwordLength',
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                semanticFormatterCallback: (double newValue) {
                  return '${newValue.round()} dollars}';
                },
              ),
              SizedBox(
                width: 120,
                child: TextField(
                  style: const TextStyle(
                    color: inputTextColor,
                    fontSize: 20,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: passwordLength.toString(),
                    hintStyle: const TextStyle(
                      color: inputTextColor,
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                    errorText: _getErrorText(),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                  ),
                  onSubmitted: (String data) {
                    int a = int.parse(data);
                    setState(() {
                      if (a < 8 || a > 32) {
                        _errorText = '密码长度应在8-32之间';
                      } else {
                        passwordLength = int.parse(data);
                        _errorText = '';
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  if (isModify) {
                    widget.savePassword();
                  }
                  isModify = !isModify;
                });
              },
              icon: Icon(isModify ? Icons.save_sharp : Icons.create),
              label: Text(isModify ? "保存" : "修改"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(detailColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}
