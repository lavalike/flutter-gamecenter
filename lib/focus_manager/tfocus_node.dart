import 'package:flutter/material.dart';

import 'key_code.dart';

/// 存放焦点控制需要的变量并设置默认值
class TFocusParam {
  int curFocusIndex = 0;
  /// left right direction
  int stepH = 0;
  /// up down direction
  int stepV = 0;
  List<TFocusNode> nodeList = [];
  TAutoScrollParam autoScrollParam = TAutoScrollParam();
}

/// 滚动控件的参数，如果需要在可滚动控件中使用焦点，添加TAutoScrollParam的参数，
/// 重写autoScroll()方法
class TAutoScrollParam {
  ScrollController scrollController;
  double verticalOffset = 0.0;
  double preOffset = 0.0;
}

/// interface
mixin TFocusNode {
  ///需要使用的变量存入focusParam
  final TFocusParam focusParam = TFocusParam();
  /// 焦点移除，递归调用此方法直到叶节点
  void blur() {
    if (focusParam.nodeList.length == 0) return;
    focusParam.nodeList[focusParam.curFocusIndex].blur();
  }
  /// 焦点聚焦，递归调用此方法直到叶节点
  void focus() {
    if (focusParam.nodeList.length == 0) return;
    focusParam.nodeList[focusParam.curFocusIndex].focus();
  }

  void autoScroll() {
    ///TODO： 如果需要在滚动控件中使用焦点，可以重写这个方法来控制滚动
    return;
  }

  /// 判断按键up的操作是否仅在当前控件中改变焦点，是则处理，否则交给上级处理
  bool towardUp() {
    if (focusParam.stepV == 0 ||
        focusParam.curFocusIndex - focusParam.stepV < 0) return true;
    blur();
    focusParam.curFocusIndex -= focusParam.stepV;
    autoScroll();
    focus();
    return false;
  }

  /// 判断按键down的操作是否仅在当前控件中改变焦点，是则处理，否则交给上级处理
  bool towardDown() {
    if (focusParam.stepV == 0 ||
        focusParam.curFocusIndex + focusParam.stepV >
            focusParam.nodeList.length - 1) return true;
    blur();
    focusParam.curFocusIndex += focusParam.stepV;
    autoScroll();
    focus();
    return false;
  }

  /// 判断按键left的操作是否仅在当前控件中改变焦点，是则处理，否则交给上级处理
  bool towardLeft() {
    if (focusParam.stepH == 0 ||
        focusParam.curFocusIndex - focusParam.stepH < 0) return true;
    blur();
    focusParam.curFocusIndex -= focusParam.stepH;
    autoScroll();
    focus();
    return false;
  }

  /// 判断按键right的操作是否仅在当前控件中改变焦点，是则处理，否则交给上级处理
  bool towardRight() {
    if (focusParam.stepH == 0 ||
        focusParam.curFocusIndex + focusParam.stepH >
            focusParam.nodeList.length - 1) return true;
    blur();
    focusParam.curFocusIndex += focusParam.stepH;
    autoScroll();
    focus();
    return false;
  }

  /// 在当前节点下可以处理焦点的blur和focus，上层无需处理，返回false。
  /// 当前节点找不到需要focus的末端节点，返回true，交由上层处理
  bool onKeyDown(int keyCode) {
    if (focusParam.nodeList.length == 0) {
      return true;
    }
    if (focusParam.nodeList[focusParam.curFocusIndex].onKeyDown(keyCode) ==
        false) return false;
    return handleKeyCode(keyCode);
  }

  ///判断方向按键，其他按键不做处理
  bool handleKeyCode(int keyCode) {
    switch (keyCode) {
      case KeyCode.keyUp:
        return towardUp();
      case KeyCode.keyDown:
        return towardDown();
      case KeyCode.keyLeft:
        return towardLeft();
      case KeyCode.keyRight:
        return towardRight();
      default:
        return true;
    }
  }
}
