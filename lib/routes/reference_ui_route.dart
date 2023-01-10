import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../focus_manager/tcl_focus_manager.dart';

class ReferenceUIRoute extends StatelessWidget {
  final TFocusWidget child;
  final FocusNode _focusNode = FocusNode();

  ReferenceUIRoute({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("page build");
    FocusScope.of(context).requestFocus(_focusNode);
    return RawKeyboardListener(
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
          RawKeyDownEvent rawKeyDownEvent = event;
          RawKeyEventDataAndroid rawKeyEventDataAndroid = rawKeyDownEvent.data;
          int keyCode = rawKeyEventDataAndroid.keyCode;
          if (child.onKeyDown(keyCode) == false) return;
          print("rui handle");
//          switch (keyCode) {
//            case KeyCode.keyLeft:
//              if (Navigator.canPop(context)) Navigator.of(context).pop();
//              break;
//            case KeyCode.keyCenter:
//
//              break;
//            default:
//          }
        }
      },
      focusNode: _focusNode,
      child: child,
    );
  }
}
