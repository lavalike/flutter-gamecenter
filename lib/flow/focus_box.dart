import 'package:flutter/material.dart';

// 瀑布流中焦点框组件
class FocusBox extends StatefulWidget {
  // 焦点框动画控制器，控制动画的开始、暂停、结束
  final AnimationController focusAnimationController;
  final double borderWidth;
  const FocusBox({Key key, this.focusAnimationController, this.borderWidth = 3})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FocusBoxState();
  }
}

class FocusBoxState extends State<FocusBox> with TickerProviderStateMixin {
  bool _showAble = false;

  AnimationController _focusAnimationController;
  // 矩形动画类，决定动画的数据和变化方式，可addListener监听Value的变化
  Animation<RelativeRect> _rectAnimation;
  RelativeRect rect;

  @override
  void initState() {
    super.initState();
    rect = RelativeRect.fromLTRB(0, 0, 0, 0);

    if (widget.focusAnimationController == null) {
      _focusAnimationController = AnimationController(
          duration: const Duration(milliseconds: 300), vsync: this);
    } else {
      _focusAnimationController = widget.focusAnimationController;
    }

  }

  @override
  Widget build(BuildContext context) {
    print('focus box build');
    Widget focusBox;
    focusBox = null;

    if (_showAble == true) {
      focusBox = PositionedTransition(
          rect: _rectAnimation,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(width: widget.borderWidth, color: Colors.deepOrange)),
          ));
    } else {
      focusBox = Container();
    }
    return focusBox;
  }

  void drawFocusBox(double l, double t, double r, double b) {
    _focusAnimationController.dispose();
    _focusAnimationController = null;
    if (_focusAnimationController == null) {
      _focusAnimationController = AnimationController(
          duration: const Duration(milliseconds: 300), vsync: this);
    }

    RelativeRect targetRect = new RelativeRect.fromLTRB(l, t, r, b);

    _rectAnimation = RelativeRectTween(begin: rect, end: targetRect)
        .animate(_focusAnimationController);
    _focusAnimationController.forward();
    setState(() {});
    rect = targetRect;
  }

  void moveLeft(double offset) {
    print("move left $offset");

    drawFocusBox(
        rect.left - offset, rect.top, rect.right + offset, rect.bottom);
  }

  void moveRight(double offset) {
    print("move right $offset");

    drawFocusBox(
        rect.left + offset, rect.top, rect.right - offset, rect.bottom);
  }

  void moveUp(double offset) {
    print("move up $offset");

    drawFocusBox(
        rect.left, rect.top - offset, rect.right, rect.bottom + offset);
  }

  void moveDown(double offset) {
    print("move down $offset");

    drawFocusBox(
        rect.left, rect.top + offset, rect.right, rect.bottom - offset);
  }

  @override
  void dispose() {
    _focusAnimationController.dispose();
    super.dispose();
  }

  void initFocusBoxInfo(double l, double t, double r, double b) {
    rect = RelativeRect.fromLTRB(l, t, r, b);
  }

  /// 显示焦点框，一般来说，在Flow Widget获得焦点得时候需要显示焦点框，
  /// 未获得焦点，焦点框不会显示。
  void show() {
    setState(() {
      RelativeRectTween rectTween =
      RelativeRectTween(begin: rect, end: rect.shift(Offset.zero));

      _rectAnimation = rectTween.animate(_focusAnimationController);
      _rectAnimation.addListener(() {

      });
      _showAble = true;
    });
  }

  void hide() {
    setState(() {
      _showAble = false;
    });
  }
}
