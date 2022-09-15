import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

typedef DialogLifeCallback = Function(
    bool show,
    GlobalKey<BaseLifeDialogState>,
    );

class BaseLifeDialog extends StatefulWidget {
  final DialogLifeCallback callback;
  final Widget child;

  const BaseLifeDialog({
    required Key key,
    required this.callback,
    required this.child,
  }) : super(key: key);

  @override
  BaseLifeDialogState createState() => BaseLifeDialogState();
}

class BaseLifeDialogState extends State<BaseLifeDialog> {
  //flutter调度阶段是否为 build/layout/paint
  bool get isPersistentCallbacks =>
      SchedulerBinding.instance?.schedulerPhase ==
          SchedulerPhase.persistentCallbacks;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    if (isPersistentCallbacks) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        //回调告知 dialog 已显示
        _noticeLife(true);
      });
    } else {
      //回调告知 dialog 已显示
      _noticeLife(true);
    }
  }

  @override
  void dispose() {
    //回调告知 dialog 已消失
    _noticeLife(false);
    super.dispose();
  }

  void _noticeLife(bool isShow) {
    widget.callback(isShow, widget.key);
  }

  ///提供关闭自己的方法
  void closeSelf() {
    if (isPersistentCallbacks) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _closeSelf();
      });
    } else {
      _closeSelf();
    }
  }

  void _closeSelf() {
    Navigator.of(context).removeRoute(ModalRoute.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

