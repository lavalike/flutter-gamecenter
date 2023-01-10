import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../common/ui_param.dart';
import '../../focus_manager/tcl_focus_manager.dart';

class PostCard extends StatefulWidget with TFocusNode {
  final Widget child;
  final double width;
  final double height;
  final int index;
  final String description;

  /// 初始显示
  final bool initOffStage;

  /// 缩放动画的方向
  final AlignmentGeometry scaleAlignment;

  PostCard(
      {Key key,
      this.child,
      this.index,
      this.description = "",
      this.initOffStage = false,
      this.width = double.infinity,
      this.height = double.infinity,
      this.scaleAlignment = Alignment.center})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    PostCardState postCardState = PostCardState();
    focusParam.nodeList.clear();
    focusParam.nodeList.add(postCardState);
    return postCardState;
  }
}

class PostCardState extends State<PostCard>
    with TFocusNode, TickerProviderStateMixin {
  Animation<double> _scaleAnimation;
  AnimationController _controller;
  Animation _scaleCurve;
  Animation _opacityCurve;
  Widget _child;

  // text opacity animation
  Animation<double> _opacityAnimation;

  BoxDecoration _boxDecoration;
  String _description;

  bool _isOff;

  @override
  void initState() {
    _isOff = widget.initOffStage;
    _child = widget.child;
    _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(7.0),
    );
    _description = widget.description;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    /// 缩放动画，分别设定放大和缩小的曲线
    _scaleCurve = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic);

    _opacityCurve = CurvedAnimation(parent: _controller, curve: Curves.ease);
    _scaleAnimation =
        Tween(begin: 1.0, end: cardTransformScale).animate(_scaleCurve);
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_opacityCurve);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed && widget.initOffStage == true) {
        setState(() {
          _isOff = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _isOff = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  void focus() {
    setState(() {
      _scaleCurve =
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
      _isOff = false;
      _boxDecoration =
          BoxDecoration(borderRadius: BorderRadius.circular(6.0), boxShadow: [
        BoxShadow(
          color: Colors.grey[800],
          offset: Offset(1, 1),
          blurRadius: 3,
        ),
        BoxShadow(
            color: Colors.grey[800], offset: Offset(-1, -1), blurRadius: 5),
        BoxShadow(
            color: Colors.grey[800], offset: Offset(1, -1), blurRadius: 5),
        BoxShadow(color: Colors.grey[800], offset: Offset(-1, 1), blurRadius: 5)
      ]);
    });
    _controller.forward();
  }

  @override
  void blur() {
    setState(() {
      _boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
      );
    });
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.loose, children: <Widget>[
      Transform.scale(
        scale: _scaleAnimation.value,
        alignment: widget.scaleAlignment,
        child: Offstage(
            offstage: _isOff,
            child: DecoratedBox(decoration: _boxDecoration, child: _child)),
      ),
      Transform.translate(
        offset: Offset(
            widget.scaleAlignment == Alignment.centerLeft
                ? widget.width * (_scaleAnimation.value - 1) / 2
                : 0,
            widget.height),
        child: Opacity(
          opacity: _opacityAnimation.value,
          child: Container(
            padding: EdgeInsets.only(top: 1),
            alignment: Alignment.topCenter,
            child: Text(
              _description,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: widget.height / 6),
            ),
          ),
        ),
      )
    ]);
  }
}
