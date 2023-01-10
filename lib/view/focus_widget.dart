import 'package:flutter/material.dart';

import '../model/focus_model.dart';
import '../model/widget_model.dart';
import '../viewmodel/main_view_model.dart';
import '../viewmodel/view_model.dart';

class FocusWidget extends StatelessWidget {
  /// Model of focus widget.
  final FocusModel _model = FocusModel(null, null);

  WidgetModel getCurFocusWidgetModel() {
    return _model.curFocusWidgetModel;
  }

  void updateFocusModel(WidgetModel widgetModel) {
    _model.updateFocusModel(widgetModel);
  }

  @override
  Widget build(BuildContext context) {
    print("FocusWidget build...");
    MainViewModel mainViewModel = BlocProvider.of<MainViewModel>(context);
    return StreamBuilder<int>(
      stream: mainViewModel.focusStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        print("StreamBuilder of FocusWidget build...");
        Color borderColor = Colors.red;
        WidgetModel widgetModel = _model.curFocusWidgetModel;
        if (widgetModel is FlowWidgetModel) {
          borderColor = Colors.transparent;
        }
        return Positioned(
          left: _model.curFocusWidgetModel.area.x,
          top: _model.curFocusWidgetModel.area.y,
          width: _model.curFocusWidgetModel.area.w,
          height: _model.curFocusWidgetModel.area.h,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 5),
                color: Colors.transparent),
          ),
        );
      },
    );
  }
}
