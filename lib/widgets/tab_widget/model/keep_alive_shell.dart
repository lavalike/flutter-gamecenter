import 'package:flutter/material.dart';

import '../../../focus_manager/tcl_focus_manager.dart';

class KeepAlvieShell extends StatefulWidget with TFocusNode {
  KeepAlvieShell({this.shouldAlive, this.shelled});

  final bool shouldAlive;
  final TFocusNode shelled;

  @override
  State createState() {
    KeepAlvieShellState keepAlvieShellState =
        KeepAlvieShellState(shouldAlive: shouldAlive, shelled: shelled);
    focusParam.nodeList.add(keepAlvieShellState);
    return keepAlvieShellState;
  }
}

class KeepAlvieShellState extends State<KeepAlvieShell>
    with AutomaticKeepAliveClientMixin, TFocusNode {
  KeepAlvieShellState({this.shouldAlive, this.shelled});

  final bool shouldAlive;
  final TFocusWidget shelled;

  @override
  void initState() {
    super.initState();
    focusParam.nodeList.add(shelled);
  }

  @override
  bool get wantKeepAlive {
    return shouldAlive;
  }

  @override
  Widget build(BuildContext context) {
    return shelled;
  }
}
