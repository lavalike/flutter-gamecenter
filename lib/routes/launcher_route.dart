import 'package:flutter/material.dart';

import '../common/ui_param.dart';
import '../focus_manager/tcl_focus_manager.dart';
import '../widgets/launcher_content.dart';
import '../widgets/top_bar.dart';

class LauncherRoute extends TFocusWidget {
  final launcherContent = LauncherContent();

  LauncherRoute({Key key, this.title}) : super(key: key) {
    focusParam.nodeList.add(launcherContent);
//    focusParam.debugTitle = 'launcherContent';
  }

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// in main.dart switch LauncherRoute with backgroundColor setting here
      backgroundColor: ReferenceColors.appBarPageBackgroundColor,
      body: Center(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TopBar(),
            ),
            Expanded(
              flex: 7,
              child: launcherContent,
            ),
          ],
        ),
      ),
    );
  }
}
