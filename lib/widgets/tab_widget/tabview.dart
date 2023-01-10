import 'package:flutter/material.dart';
import '../../common/ui_param.dart';
import '../../focus_manager/tcl_focus_manager.dart';
import '../../routes/content_flow_route.dart';
import '../../widgets/launcher_content.dart';
import '../../widgets/tab_widget/model/keep_alive_shell.dart';

class UnderTabViewBar extends TFocusWidget {
  UnderTabViewBar({this.tabController, this.tabList}) {
    focusParam.nodeList.add(launcherRoute);
    focusParam.nodeList.add(contentFlowRoute);
    focusParam.stepH = 1;
  }

  final TabController tabController;
  final List<String> tabList;
  final ContentFlowRoute contentFlowRoute = ContentFlowRoute();
  final LauncherContent launcherRoute = LauncherContent();

  @override
  bool handleKeyCode(int keyCode) {
    if (keyCode == KeyCode.keyLeft || keyCode == KeyCode.keyRight) {
      super.handleKeyCode(keyCode);
      return true;
    }
    return super.handleKeyCode(keyCode);
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: tabList.map((item) {
        switch (item) {
          case tableName0:
            return KeepAlvieShell(
              shouldAlive: true,
              shelled: launcherRoute,
            );
            break;
          case tableName1:
            return KeepAlvieShell(
              shouldAlive: true,
              shelled: contentFlowRoute,
            );
            break;
        }
        return LauncherContent();
      }).toList(),
    );
  }
}
