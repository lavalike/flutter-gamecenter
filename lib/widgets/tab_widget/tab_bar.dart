import 'package:flutter/material.dart';

import '../../common/ui_param.dart';
import '../../focus_manager/tcl_focus_manager.dart';

class UnderTabBar extends StatefulWidget with TFocusNode {
  UnderTabBar({this.tabController, this.tabList}) {
    for (int i = 0; i < tabList.length; i++) {
      focusParam.nodeList.add(TFocusWidget());
    }
    focusParam.stepH = 1;
  }

  final UnderTabBarState underTabBarState = UnderTabBarState();
  final TabController tabController;
  final List<String> tabList;
  final double iconRadius = 2.2;

  @override
  void focus() {
    tabController.animateTo(focusParam.curFocusIndex);
  }

  @override
  State createState() => underTabBarState;
}

class UnderTabBarState extends State<UnderTabBar> {
  Color colorMe = ReferenceColors.textFocusColor;

  void changeTabTextColor() {
    setState(() {
      colorMe = (colorMe == ReferenceColors.textFocusColor)
          ? ReferenceColors.topBarTextColor
          : ReferenceColors.textFocusColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ReferenceColors.viewPageBackgroundColor,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 6,
            child: TabBar(
              isScrollable: true,
              //是否可以滚动
              controller: widget.tabController,
              labelColor: colorMe,
              unselectedLabelColor: ReferenceColors.topBarTextColor,
              labelStyle: tabBarLabelStyle,
              tabs: widget.tabList.map((item) {
                return Tab(
                  text: item,
                );
              }).toList(),
            ),
          ),
          Expanded(
              flex: 4,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: Transform.scale(
                      scale: widget.iconRadius,
                      child: Icon(Icons.usb,
                          color: ReferenceColors.topBarTextColor),
                    ),
                  ),
                  Expanded(
                    child: Transform.scale(
                      scale: widget.iconRadius,
                      child: Icon(Icons.input,
                          color: ReferenceColors.topBarTextColor),
                    ),
                  ),
                  Expanded(
                    child: Transform.scale(
                      scale: widget.iconRadius,
                      child: Icon(Icons.wifi,
                          color: ReferenceColors.topBarTextColor),
                    ),
                  ),
                  Expanded(
                    child: Transform.scale(
                      scale: widget.iconRadius,
                      child: Icon(
                        Icons.settings,
                        color: ReferenceColors.topBarTextColor,
                      ),
                    ),
                  )
                ],
              )),
          Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}
