import 'package:flutter/material.dart';


promptDialog(BuildContext context,String text){
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("提示"),
          content:  Text(text),
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

class LoadingDialog extends Dialog {
  const LoadingDialog(this.canceledOnTouchOutside, {Key? key})
      : super(key: key);

  ///点击背景是否能够退出
  final bool canceledOnTouchOutside;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(

          ///背景透明
          color: Colors.transparent,

          ///保证控件居中效果
          child: Stack(
            children: <Widget>[
              GestureDetector(
                ///点击事件
                onTap: () {
                  if (canceledOnTouchOutside) {
                    Navigator.pop(context);
                  }
                },
              ),
              _dialog()
            ],
          )),
    );
  }

  Widget _dialog() {
    return Center(
      ///弹框大小
      child: SizedBox(
        width: 120.0,
        height: 120.0,
        child: Container(
          ///弹框背景和圆角
          decoration: const ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                child: Text(
                  "加载中",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
