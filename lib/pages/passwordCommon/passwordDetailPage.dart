// 详情页
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../common/passwordUtils.dart';
import '../../pkg/save/client.dart';
import '../../utils/modifyData.dart';
import '../../utils/utils.dart';
import './passwordUtils.dart';
import 'data.dart';
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
    if (widget.detailData.selectAccount.userName == "") {
      return;
    }
    bool isNewData = false;
    if (widget.detailData.selectIndex == -2) {
      widget.detailData.selectIndex = widget.detailData.decodeData.length - 1;
      widget.detailData.decodeData.add(widget.detailData.selectAccount);
      isNewData = true;
    } else if (widget.detailData.selectIndex == -1) {
      widget.detailData.decodeData.add(widget.detailData.selectAccount);
      isNewData = true;
    } else {
      widget.detailData.decodeData[widget.detailData.selectIndex] =
          widget.detailData.selectAccount;
    }

    widget.detailData.webSiteData.isModify = true;
    widget.detailData.webSiteData.webKey = widget.detailData.webSite.webKey;
    widget.detailData.webSiteData.version =
        widget.detailData.webSiteData.version + 1;

    if (isNewData) {
      Store().insert(
          modelData: await encodePassword(
              widget.detailData.webSiteData, widget.detailData.decodeData));
    } else {
      Store().update(
          modelData: await encodePassword(
              widget.detailData.webSiteData, widget.detailData.decodeData));
    }

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
                image: "assets/icons/defaultWebsite.ico",
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
    if (widget.detailData.selectAccount.userName == "") {
      isModify = true;
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

  randomPassword() {
    passwordController.text = getRandomPassword(passwordLength);
    widget.detailData.selectAccount.password = passwordController.text;
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
            widget.detailData.webSite.name,
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
          padding: EdgeInsets.only(
              left: 30,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      randomPassword();
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
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      passwordLength--;
                      _sliderValue--;
                      randomPassword();
                    });
                  },
                  icon: const Icon(Icons.remove)),
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
              IconButton(
                  onPressed: () {
                    setState(() {
                      passwordLength++;
                      _sliderValue++;
                      randomPassword();
                    });
                  },
                  icon: const Icon(Icons.add)),
              SizedBox(
                width: 120,
                child: Text(passwordLength.toString(),
                    style: const TextStyle(
                      color: inputTextColor,
                      fontSize: 20,
                    )),
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