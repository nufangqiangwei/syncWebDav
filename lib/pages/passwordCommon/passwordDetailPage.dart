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
class PasswordDetailPage extends StatelessWidget {
  const PasswordDetailPage(
      {Key? key,
        this.maxWidth})
      : super(key: key);
  final double? maxWidth;

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
              PassWordDataController.saveAccount();
              PassWordDataController.blackPage();
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
            maxWidth: maxWidth
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
        this.maxWidth})
      : super(key: key);
  final double? maxWidth;

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
            maxWidth: maxWidth,
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
        this.maxWidth})
      : super(key: key);
  final double? maxWidth;

  @override
  State<StatefulWidget> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  double _sliderValue = 8;
  int passwordLength = 8;
  String _errorText = '';
  bool isModify = false;
  bool modifyPassword = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  initState() {
    super.initState();
    PassWordDataController.listenerAccountChange(() {
      if(mounted){
        setState((){
          modifyPassword=false;
        });
      }
    });
  }

  @override
  dispose(){
    super.dispose();
    PassWordDataController.removeListenerAccountChange((){
      if(mounted){
        setState((){});
      }
    });
    passwordController.dispose();
    userNameController.dispose();
  }

  setUserPasswordData(){
    if (PassWordDataController.selectAccountData.userName == "") {
      isModify = true;
    }
    if(!modifyPassword){
      userNameController.text = PassWordDataController.selectAccountData.userName;
      passwordController.text = PassWordDataController.selectAccountData.password;
      if (PassWordDataController.selectAccountData.password.isNotEmpty) {
        _sliderValue = PassWordDataController.selectAccountData.password.length.toDouble();
        passwordLength = PassWordDataController.selectAccountData.password.length;
      }
    }

  }

  _getErrorText() {
    return _errorText;
  }

  randomPassword() {
    modifyPassword = true;
    var pa = getRandomPassword(passwordLength);
    passwordController.text = pa;
    PassWordDataController.setSelectAccountPassword = pa;
  }

  @override
  Widget build(BuildContext context) {
    setUserPasswordData();
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
            PassWordDataController.selectWebSite.name,
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
                  controller:userNameController,
                  decoration: const InputDecoration(
                    hintText: "用户名",
                    hintStyle: TextStyle(
                      color: inputTextColor,
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                  ),
                  readOnly: !isModify,
                  onChanged: (String value) {
                    PassWordDataController.setSelectAccountUserName = value;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text: PassWordDataController.selectAccountData.userName
                  ));
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
                  decoration: const InputDecoration(
                    hintText: "密码",
                    hintStyle: TextStyle(
                      color: inputTextColor,
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                  ),
                  readOnly: !isModify,
                  onChanged: (String value) {},
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
                    randomPassword();
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
                    PassWordDataController.saveAccount();
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