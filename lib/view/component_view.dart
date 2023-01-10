import 'package:flutter/material.dart';

import '../model/component_model.dart';
import '../model/widget_model.dart';
import '../view/common_widget.dart';
import '../viewmodel/main_view_model.dart';
import '../viewmodel/view_model.dart';

/// Build widgets by models.
void _buildWidgetsByModels(
    List<WidgetModel> input, List<StatelessWidget> output) {
  for (var model in input) {
    if (model is FlowWidgetModel) {
      output.add(MagicWidget(model));
    } else if (model is PosterWidgetModel) {
      output.add(PosterWidget(model));
    } else if (model is TitleWidgetModel) {
      output.add(TitleWidget(model));
    } else {
      output.add(WindowWidget(model));
    }
  }
}

abstract class View {
  /// Get widget model by id.
  WidgetModel getWidgetModelById(int id);
}

class HeaderView extends StatelessWidget implements View {
  /// Model of header view.
  final HeaderComponentModel _model = HeaderComponentModel();

  /// Widgets of header view.
  final List<StatelessWidget> _titleWidgets = List();

  HeaderView() {
    _buildWidgetsByModels(_model.getWidgetModels(), _titleWidgets);
  }

  @override
  Widget build(BuildContext context) {
    print("HeaderView build...");
    return Positioned(
      left: _model.area.x,
      top: _model.area.y,
      width: _model.area.w,
      height: _model.area.h,
      child: Stack(
        children: _titleWidgets,
      ),
    );
  }

  @override
  WidgetModel getWidgetModelById(int id) {
    return _model.getWidgetModelById(id);
  }
}

class ContentView extends StatelessWidget implements View {
  /// Model of content view.
  final ContentComponentModel _model = ContentComponentModel();

  /// Widgets of content view.
  final List<StatelessWidget> _contentWidgets = List();

  @override
  Widget build(BuildContext context) {
    print("ContentView build...");
    MainViewModel mainViewModel = BlocProvider.of<MainViewModel>(context);
    return StreamBuilder<int>(
      stream: mainViewModel.tabIndexStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        print("StreamBuilder of ContentView build...");
        _contentWidgets.clear();
        _buildWidgetsByModels(_model.getWidgetModels(), _contentWidgets);
        return Positioned(
          left: _model.area.x,
          top: _model.area.y,
          width: _model.area.w,
          height: _model.area.h,
          child: Stack(
            children: _contentWidgets,
          ),
        );
      },
    );
  }

  bool shouldControlFocus(int id) {
    if (id == 9 && _model.tabIndex == 2) {
      return true;
    } else {
      return false;
    }
  }

  bool handleKeyEvent(int keyCode) {
    MagicWidget magicWidget = _contentWidgets[3];
    return magicWidget.handleKeyEvent(keyCode);
  }

  void focus() {
    MagicWidget magicWidget = _contentWidgets[3];
    magicWidget.focus();
  }

  void blur() {
    MagicWidget magicWidget = _contentWidgets[3];
    magicWidget.blur();
  }

  bool updateTabIndex(int id) {
    if (id < 3 && _model.tabIndex != id) {
      _model.tabIndex = id;
      return true;
    } else {
      return false;
    }
  }

  @override
  WidgetModel getWidgetModelById(int id) {
    return _model.getWidgetModelById(id);
  }
}
