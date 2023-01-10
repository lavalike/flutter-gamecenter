import 'package:flutter/material.dart';

import '../data/constant.dart';
import '../data/key_code.dart';
import '../flow/flow_widget.dart';
import '../model/widget_model.dart';

/// Widget that draws a transparent window.
class WindowWidget extends StatelessWidget {
  WidgetModel get model => _model;
  final WidgetModel _model;

  WindowWidget(this._model);

  @override
  Widget build(BuildContext context) {
    print("build WindowWidget : id = ${_model.id}");
    return Positioned(
      left: _model.area.x,
      top: _model.area.y,
      width: _model.area.w,
      height: _model.area.h,
      child: Container(
        color: Colors.black,
      ),
    );
  }
}

/// Widget that draws a poster.
class PosterWidget extends StatelessWidget {
  PosterWidgetModel get model => _model;
  final PosterWidgetModel _model;

  PosterWidget(this._model);

  @override
  Widget build(BuildContext context) {
    print("build PosterWidget : id = ${_model.id}, url = ${_model.url}");
    return Positioned(
      left: _model.area.x,
      top: _model.area.y,
      width: _model.area.w,
      height: _model.area.h,
      child: Image.network(_model.url,
          width: _model.area.w, height: _model.area.h),
    );
  }
}

/// Widget that draws a title.
class TitleWidget extends StatelessWidget {
  TitleWidgetModel get model => _model;
  final TitleWidgetModel _model;

  TitleWidget(this._model);

  @override
  Widget build(BuildContext context) {
    print("build TitleWidget : id = ${_model.id}");
    return Positioned(
      left: _model.area.x,
      top: _model.area.y,
      width: _model.area.w,
      height: _model.area.h,
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            _model.text,
            style: TextStyle(
              fontSize: _model.fontSize,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}

/// Widget that draws a flow.
class MagicWidget extends StatelessWidget {
  static Future<List<String>> retrieveData() async {
    List<String> result = List();
    await Future.delayed(Duration(seconds: 1)).then((e) {
      for (int i = 0; i < 20; i++)
        result.add(GlobalData.urlHead + HomeData.appUrls[0]);
    });
    return result;
  }

  FlowWidgetModel get model => _model;
  final FlowWidgetModel _model;
  final FlowWidget _flowWidget = FlowWidget(
      columnCount: 4, maxCacheSize: 16, retrieveDataCallback: retrieveData);

  MagicWidget(this._model);

  bool handleKeyEvent(int keyCode) {
    switch (keyCode) {
      case KeyCode.up:
      case KeyCode.down:
      case KeyCode.left:
      case KeyCode.right:
        return _flowWidget.handleKeyEvent(keyCode);
      default:
        return false;
    }
  }

  void focus() {
    _flowWidget.focus();
  }

  void blur() {
    _flowWidget.blur();
  }

  @override
  Widget build(BuildContext context) {
    print("build MagicWidget : id = ${_model.id}");
    return Positioned(
      left: _model.area.x,
      top: _model.area.y,
      width: _model.area.w,
      height: _model.area.h,
      child: _flowWidget,
    );
  }
}
