import 'package:flutter/material.dart';
import '../common/images_url.dart';
import '../common/ui_param.dart';
import '../focus_manager/tcl_focus_manager.dart';
import '../widgets/flow_widget/flow_set.dart';

class ContentFlowRoute extends TFocusWidget {
  final FlowSet flowSet = FlowSet(
    columnCount: 5,
    retrieveData: retrieveData,
    scrollController: ScrollController(),
  );

  ContentFlowRoute() {
    focusParam.nodeList.clear();
    focusParam.nodeList.add(flowSet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// in main.dart switch ContentFlowRoute with backgroundColor setting here
        backgroundColor: ReferenceColors.viewPageBackgroundColor,
        body: Column(
          children: <Widget>[
            Expanded(
              child: flowSet,
            )
          ],
        ));
  }
}

Future<List<Widget>> retrieveData() async {
  List<Widget> list = [];
  await Future.delayed(Duration(milliseconds: 1000)).then((e) {
    list = homeUris.map((imagePath) {
      return Image.asset(
        imagePath,
        fit: BoxFit.contain,
      );
    }).toList();
  });
  return list;
}
