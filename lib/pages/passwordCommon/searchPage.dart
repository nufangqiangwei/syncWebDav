import 'package:flutter/material.dart';
import 'package:sync_webdav/pages/passwordCommon/passwordUtils.dart';

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
  final ValueChanged<String>? onSearch;

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
  // void _onCancelInput() {
  //   _controller.clear();
  //   _focusNode.unfocus();
  //   setState(() {});
  //   widget.onCancel?.call();
  // }

  Widget _suffix() {
    if (!isTextEmpty) {
      return GestureDetector(
        onTap: _onClearInput,
        child: SizedBox(
          width: widget.height,
          height: widget.height,
          child: const Icon(Icons.cancel, size: 22, color: Color(0xFF999999)),
        ),
      );
    }
    return widget.suffix ?? const SizedBox();
  }

  // List<Widget> _actions() {
  //   List<Widget> list = [];
  //   if (isFocus || !isTextEmpty) {
  //     list.add(GestureDetector(
  //       onTap: _onCancelInput,
  //       child: Container(
  //         constraints: BoxConstraints(minWidth: 48),
  //         alignment: Alignment.center,
  //         child: Text(
  //           '取消',
  //           style: TextStyle(color: Color(0xFF666666), fontSize: 15),
  //         ),
  //       ),
  //     ));
  //   } else if (!isActionEmpty) {
  //     list.addAll(widget.actions);
  //   }
  //   return list;
  // }

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
