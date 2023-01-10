import 'package:flutter/material.dart';

import 'tfocus_node.dart';

/// TFocusWidget是TFocusNode的封装，便于在需要时直接使用其Widget属性。
/// nodeList为当前节点的子节点列表，叶节点不需要添加。
/// 根据子节点的纵向或横向布局来设定步长stepVertical，stepHorizontal。
/// currentIndex为当前焦点所在的子节点，默认为0

class TFocusWidget extends StatelessWidget with TFocusNode {
  TFocusWidget({Key key,
    this.child,
    int stepHorizontal = 0,
    int stepVertical = 0,
    int currentIndex = 0,
    List<TFocusNode> nodeList})
      : super(key: key) {
    focusParam.stepH = stepHorizontal;
    focusParam.stepV = stepVertical;
    focusParam.curFocusIndex = currentIndex;
    if (nodeList != null) this.focusParam.nodeList = nodeList;
  }

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}



