import 'package:flutter/material.dart';

import '../common/ui_param.dart';
import '../focus_manager/tcl_focus_manager.dart';
import '../widgets/tab_widget/tab_bar.dart';
import '../widgets/tab_widget/tabview.dart';

class AppBarRoute extends TFocusWidget {
  @override
  Widget build(BuildContext context) {
    var _appBarRouteScaffold = AppBarRouteScaffold();
    focusParam.nodeList.add(_appBarRouteScaffold);
    return _appBarRouteScaffold;
  }
}

class AppBarRouteScaffold extends StatefulWidget with TFocusNode {
  @override
  State createState() {
    var _appBarRouteScaffoldState = AppBarRouteScaffoldState();
    focusParam.nodeList.add(_appBarRouteScaffoldState);
    return _appBarRouteScaffoldState;
  }
}

class AppBarRouteScaffoldState extends State<AppBarRouteScaffold>
    with SingleTickerProviderStateMixin, TFocusNode {
  AppBarRouteScaffoldState({this.otherTabNum = 0});

  ///  可添加tab页数量
  final int otherTabNum;
  UnderTabBar underTabBar;
  UnderTabViewBar underTabViewBar;
  TabController mController;
  static List<String> tabList;

  /// 填充tab标签
  void initTabList() {
    tabList = [
      tableName0,
      tableName1,
    ];
    for (int i = 0; i < otherTabNum; i++) {
      tabList.add('tabOtherIndex$otherTabNum');
    }
  }

  /// 实例化
  void initInsideWidget() {
    underTabViewBar = UnderTabViewBar(
      tabController: mController,
      tabList: tabList,
    );
    underTabBar = UnderTabBar(
      tabController: mController,
      tabList: tabList,
    );
  }

  void initNodeList() {
    focusParam.nodeList.add(underTabBar);
    focusParam.nodeList.add(underTabViewBar);
    focusParam.stepV = 1;
  }

  @override
  void initState() {
    super.initState();
    initTabList();
    mController = TabController(
      length: tabList.length,
      vsync: this,
    );
    initInsideWidget();
    initNodeList();
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  bool onKeyDown(int keyCode) {
    if (focusParam.nodeList[focusParam.curFocusIndex].onKeyDown(keyCode) ==
        false) {
      if (focusParam.curFocusIndex == 0)
        switch (keyCode) {
          case KeyCode.keyRight:
            focusParam.nodeList[1].focusParam.curFocusIndex +=
                focusParam.nodeList[1].focusParam.stepH;
            break;
          case KeyCode.keyLeft:
            focusParam.nodeList[1].focusParam.curFocusIndex -=
                focusParam.nodeList[1].focusParam.stepH;
            break;
        }
      return false;
    }
    if (focusParam.curFocusIndex == 1)
      switch (keyCode) {
        case KeyCode.keyLeft:
          return focusParam.nodeList[0].towardLeft();
        case KeyCode.keyRight:
          return focusParam.nodeList[0].towardRight();
      }
    return super.handleKeyCode(keyCode) ? true : changeTabTextColor();
  }

  bool changeTabTextColor() {
    underTabBar.underTabBarState.changeTabTextColor();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReferenceColors.appBarPageBackgroundColor,
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(child: underTabBar),
          Expanded(
            flex: 6,
            child: underTabViewBar,
          ),
        ],
      ),
    );
  }
}
