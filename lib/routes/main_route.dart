import 'package:flutter/material.dart';

import '../focus_manager/tcl_focus_manager.dart';
import '../widgets/flow_widget/flow_card.dart';

class ChooseDisplayRoute extends TFocusWidget {
  final Map routes = {'Launcher': '/launcher', 'Flow': '/flow'};
  BuildContext _context;
  final FocusNode focusNode;

  ChooseDisplayRoute({Key key, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    focusParam.stepH = 1;
//    focusParam.debugTitle = "main route";
    return Scaffold(
        body: GridView.builder(
            padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.5),
            itemCount: routes.length,
            itemBuilder: (context, index) {
              var child = PostCard(
                child: Center(child: Text(routes.keys.elementAt(index))),
                index: index,
              );
              focusParam.nodeList.add(child);
              return child;
            }));
  }

  @override
  bool onKeyDown(int keyCode) {
    super.onKeyDown(keyCode);
    if (keyCode == KeyCode.keyCenter) {
      switch (focusParam.curFocusIndex) {
        case 0:
          //focusParam.focusNode.unfocus();
          Navigator.pushNamed(_context, '/launcher');
          return true;
        case 1:
          //focusParam.focusNode.unfocus();
          Navigator.pushNamed(_context, '/flow');

          return true;
        default:
      }
    }
    return false;
  }
}
