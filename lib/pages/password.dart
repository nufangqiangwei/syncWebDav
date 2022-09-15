import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_webdav/common/Global.dart';
import 'package:sync_webdav/common/passwordUtils.dart';
import 'package:sync_webdav/model/JsonModel.dart';
import 'package:sync_webdav/model/class.dart';
import 'package:sync_webdav/model/model.dart';
import 'package:sync_webdav/utils/modifyData.dart';

import 'drawer.dart';

class PassWordPage extends StatefulWidget {
  const PassWordPage({Key? key}) : super(key: key);

  @override
  State<PassWordPage> createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> {
  late String page = 'webSite';
  List<AccountData> webSiteAccountData = [];
  late AccountData accountDetail;
  WebSiteAccountData detailData = WebSiteAccountData();

  @override
  initState() {
    page = 'webSite';
    super.initState();
  }

  Widget showPage(BuildContext context) {
    switch (page) {
      case 'webSite':
        {
          return WebSitePage(touchFunc: onTouchWebSite);
        }
      case 'account':
        {
          return UserAccountPage(
              web: detailData.webSite,
              accountData: webSiteAccountData,
              touchFunc: onTouchAccount);
        }
      case 'detail':
        {
          return UserAccountDetailPage(
              detailData: detailData, blackPage: blackPage);
        }
      case "modifyDetail":
        {
          return ModifyAccountDetailPage(
            detailData: detailData,
            webSiteAccountData: webSiteAccountData,
            blackPage: blackPage,
          );
        }
      default:
        {
          return WebSitePage(touchFunc: onTouchWebSite);
        }
    }
  }

  blackPage(int? status) {
    switch (page) {
      case 'webSite':
        {
          return true;
        }
      case 'account':
        {
          detailData = WebSiteAccountData();

          setState(() {
            page = 'webSite';
          });
          return false;
        }
      case 'detail':
        {
          if (status == null) {
            setState(() {
              page = 'account';
            });
          } else {
            setState(() {
              page = 'modifyDetail';
            });
          }
          return false;
        }
      case "modifyDetail":
        {
          setState(() {
            page = 'detail';
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
    detailData.webSite = web;
    detailData.webSiteData =
        await Password().select().webKey.equals(web.webKey).toSingleOrDefault();
    detailData.webSiteData.webKey ??= web.webKey;
    webSiteAccountData = await decodePassword(detailData.webSiteData);
    setState(() {
      page = 'account';
    });
  }

  onTouchAccount(AccountData account, int index) {
    detailData.selectIndex = index;
    setState(() {
      page = 'detail';
    });
  }

  Widget? addIcon() {
    if (page == "webSite" || page == "detail" || page == "modifyDetail") {
      return null;
    }
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          page = 'modifyDetail';
        });
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add, color: Colors.white,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBarSearch(),
      drawer: const MyDrawer(),
      body: WillPopScope(
        child: showPage(context),
        onWillPop: () async {
          return blackPage(null);
        },
      ),
      floatingActionButton: addIcon(),
    );
  }
}

class WebSitePage extends StatelessWidget {
  const WebSitePage({Key? key, required this.touchFunc}) : super(key: key);
  final Function(WebSite) touchFunc;

  @override
  Widget build(BuildContext context) {
    List<WebSite> webSiteList = Provider.of<GlobalParams>(context).webSiteList;
    print("webSiteList: ${webSiteList.length}");
    return ListView.separated(
      itemCount: webSiteList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var web = webSiteList[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x00000000), width: 0.5),
            // 边色与边宽度
            color: const Color.fromARGB(255, 219, 244, 241),
            // 底色
            //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ), // 也可控件一边圆角大小
          ),
          child: ListTile(
            // leading:Image(image: AssetImage(web.icon)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/icons/defaultWebsite.ico",
                image: web.icon!,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/icons/defaultWebsite.ico");
                },
              ),
            ),
            title: Text(web.name!),
            subtitle: Text(web.url!, overflow: TextOverflow.ellipsis),
            // tileColor: Colors.pinkAccent,
            onTap: () {
              touchFunc(web);
            },
          ),
        );
      },
      padding: const EdgeInsets.all(10),
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.all(5),
        );
      },
    );
  }
}

class UserAccountPage extends StatelessWidget {
  const UserAccountPage(
      {Key? key,
      required this.web,
      required this.accountData,
      required this.touchFunc})
      : super(key: key);
  final List<AccountData> accountData;
  final Function(AccountData, int) touchFunc;
  final WebSite web;

  Widget weiSiteHeader() {
    return Column(
      // crossAxisAlignment:CrossAxisAlignment.baseline,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/icons/defaultWebsite.ico",
            image: web.icon!,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/icons/defaultWebsite.ico");
            },
          ),
        ),
        Text(
          web.name!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text("上次修改时间  ${web.dateCreated?.toString()}"),
        const Text("网站改密规则"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: accountData.length + 1,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return weiSiteHeader();
        }
        index--;
        var account = accountData[index];
        return ListTile(
          // leading:Image(image: AssetImage(web.icon)),
          // leading: Image.asset(web.icon),
          title: Text(account.userName),
          subtitle: const Text('*********'),
          onTap: () {
            touchFunc(account, index);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.black);
      },
    );
  }
}

class UserAccountDetailPage extends StatelessWidget {
  const UserAccountDetailPage(
      {Key? key, required this.detailData, required this.blackPage})
      : super(key: key);
  final WebSiteAccountData detailData;
  final Function(int? status) blackPage;
  final isRead = true;

  @override
  Widget build(BuildContext context) {
    var windowsWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding:
          EdgeInsets.symmetric(vertical: 0, horizontal: windowsWidth * 0.07),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            TextFormField(
              readOnly: isRead,
              initialValue: detailData.selectAccount.userName,
              // The validator receives the text that the user has entered.
              validator: (value) {},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.verified_user),
                labelText: "用户名",
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextFormField(
              readOnly: isRead,
              initialValue: detailData.selectAccount.password,
              // The validator receives the text that the user has entered.
              validator: (value) {},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.password),
                labelText: "密码",
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
                readOnly: isRead,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.speaker_notes_outlined),
                  labelText: "备注",
                )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
                readOnly: isRead,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.speaker_notes_outlined),
                  labelText: "备注",
                )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
                readOnly: isRead,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.speaker_notes_outlined),
                  labelText: "备注",
                )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
                readOnly: isRead,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.speaker_notes_outlined),
                  labelText: "备注",
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  blackPage(1);
                },
                child: const Text('修改'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModifyAccountDetailPage extends StatefulWidget {
  const ModifyAccountDetailPage(
      {Key? key,
      required this.detailData,
      required this.webSiteAccountData,
      required this.blackPage})
      : super(key: key);
  final WebSiteAccountData detailData;
  final List<AccountData> webSiteAccountData;
  final Function(int? status) blackPage;

  @override
  State<StatefulWidget> createState() => _ModifyAccountDetailPageState();
}

class _ModifyAccountDetailPageState extends State<ModifyAccountDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  double _sliderValue = 12;

  getRandomPassword(int passwordLength) {
    final _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#%^&*';
    final randomString = List.generate(passwordLength,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();
    print(randomString);
    return randomString;
  }

  savePassword() async {

    widget.blackPage(1);
  }

  @override
  Widget build(BuildContext context) {
    passwordController.text = widget.detailData.selectAccount.password;
    var windowsWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding:
          EdgeInsets.symmetric(vertical: 0, horizontal: windowsWidth * 0.07),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            TextFormField(
              initialValue: widget.detailData.selectAccount.userName,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入用户名';
                }
                widget.detailData.selectAccount.userName = value;
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.verified_user),
                labelText: "用户名",
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(children: [
              SizedBox(
                width: windowsWidth * 0.70,
                child: TextFormField(
                  controller: passwordController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      passwordController.text =
                          getRandomPassword(_sliderValue.toInt());
                      return null;
                    }
                    widget.detailData.selectAccount.password = value;
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.password),
                    labelText: "密码",
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              IconButton(
                icon: const Icon(Icons.add_alarm),
                onPressed: () {
                  passwordController.text =
                      getRandomPassword(_sliderValue.toInt());
                },
              ),
              // const SizedBox(
              //   width: 20,
              //   child: Icon(Icons.add_alarm),
              // )
            ]),
            Row(
              children: [
                const Text('位数'),
                SizedBox(
                  width: windowsWidth * 0.7,
                  child: Slider.adaptive(
                    divisions: 16,

                    ///已滑动过得颜色
                    activeColor: Colors.red,

                    ///未滑动的颜色
                    thumbColor: Colors.cyan,
                    min: 8,
                    max: 24,

                    ///当前进度 取值(0 - 1)
                    value: _sliderValue,
                    //进度条进度 返回值为(0-1)
                    onChanged: (double value) {
                      setState(() {
                        _sliderValue = value;
                        //拖动进度条改变数值
                      });
                    },
                    //滑动开始回调
                    onChangeStart: (double value) {},
                    //滑动结束回调
                    onChangeEnd: (double value) {
                      passwordController.text =
                          getRandomPassword(_sliderValue.toInt());
                    },
                  ),
                ),
                Text(_sliderValue.toInt().toString())
              ],
            ),
            const TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.speaker_notes_outlined),
              labelText: "备注",
            )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.speaker_notes_outlined),
              labelText: "备注",
            )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.speaker_notes_outlined),
              labelText: "备注",
            )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.speaker_notes_outlined),
              labelText: "备注",
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    savePassword();
                  }
                },
                child: const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class SearchPassword extends StatefulWidget {
  const SearchPassword({Key? key}) : super(key: key);

  @override
  State<SearchPassword> createState() => _SearchPassword();
}

class _SearchPassword extends State<SearchPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white12,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.black.withOpacity(0.1),
      ),
      child: const SearchInput(),
    );
  }
}

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchInput();
}

class _SearchInput extends State<SearchInput> {
  FocusNode focusNode = FocusNode();

  RelativeRect _position(RenderBox popupButtonObject, RenderBox overlay) {
    // var Left = popupButtonObject.localToGlobal(
    //     popupButtonObject.size.bottomLeft(Offset.zero),
    //     ancestor: overlay);
    // var Right = popupButtonObject.localToGlobal(
    //     popupButtonObject.size.bottomRight(Offset.zero),
    //     ancestor: overlay);
    // print('Left X:${Left.dx},Left Y: ${Left.dy}');
    // print('Right X:${Right.dx},Right Y: ${Right.dy}');
    // // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
    // var xx = RelativeRect.fromSize(
    //   Rect.fromPoints(Left,Right),
    //   Size(overlay.size.width, overlay.size.height),
    // );
    // print('xx.left${xx.left}, xx.top${xx.top}, xx.right${xx.right}, xx.bottom${xx.bottom}');
    return const RelativeRect.fromLTRB(41, 107, 41, 900);
  }

  ///openMenu
  _openMenu() {
    // Here we get the render object of our physical button, later to get its size & position
    final popupButtonObject = context.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    var overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    // print('popupButtonObjectWidth: ${popupButtonObject.size.width}, popupButtonObjectHeight: ${popupButtonObject.size.height}');
    // print('overlayWidth: ${overlay.size.width},overlayHeight: ${overlay.size.height}');
    showMenu(
      context: context,
      position: _position(popupButtonObject, overlay),
      items: <PopupMenuEntry>[
        const PopupMenuItem(child: Text("RNG")), // Menu Item
        const PopupMenuItem(child: Text("342")), // Menu Item
        const PopupMenuItem(child: Text("sdrf")), // Menu Item
        const PopupMenuItem(child: Text("rt34")), // Menu Item
        const PopupMenuItem(child: Text("wgerfg")), // Menu Item
        const PopupMenuItem(child: Text("dtg34")), // Menu Item
        const PopupMenuItem(child: Text("345ref")), // Menu Item
        const PopupMenuItem(child: Text("45yrt")), // Menu Item
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        _openMenu();
        // Provider.of<GlobalParams>(context,listen: false).ModifyWebSiteList(initDatabaseData());
      },
      focusNode: focusNode,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.blue[500],
        ),
        hintText: "搜索",
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
*/
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
    return AppBar(
      titleSpacing: 0,
      leading: isFocus ? const SizedBox() : widget.leading,
      leadingWidth: isFocus ? 15 : kToolbarHeight,
      title: Container(
        margin: EdgeInsets.only(right: right, left: left),
        height: widget.height,
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Row(
          children: [
            SizedBox(
              width: widget.height,
              height: widget.height,
              child: Icon(Icons.search, size: 22, color: Color(0xFF999999)),
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
                  hintStyle:
                      const TextStyle(fontSize: 15, color: Color(0xFF999999)),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Color(0xFF333333), height: 1.3),
                textInputAction: TextInputAction.search,
                onTap: widget.onTap,
                onSubmitted: widget.onSearch,
              ),
            ),
            _suffix(),
          ],
        ),
      ),
      actions: _actions(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
