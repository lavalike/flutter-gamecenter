import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/constant.dart';
import '../data/key_code.dart';
import '../model/widget_model.dart';
import '../view/component_view.dart';
import '../view/focus_widget.dart';
import '../viewmodel/main_view_model.dart';
import '../viewmodel/view_model.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// Focus node to handle global key event.
  final FocusNode _focusNode = FocusNode();

  /// Scroll controller to control global scroll.
  final ScrollController _controller = ScrollController();

  /// View of header.
  final HeaderView _headerView = HeaderView();

  /// View of content.
  final ContentView _contentView = ContentView();

  /// View of focused rectangle.
  final FocusWidget _focusWidget = FocusWidget();

  /// Current scroll offset.
  double _scrollOffset = 0;

  /// Control focus by self or not.
  bool _hasFocusControl = true;

  @override
  void initState() {
    print("_MainViewState initState...");
    _focusWidget.updateFocusModel(_headerView.getWidgetModelById(0));
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("_MainViewState build...");
    FocusScope.of(context).requestFocus(_focusNode);
    return RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: ScrollConfiguration(
          behavior: NullAnimationBehavior(),
          child: ListView.builder(
              controller: _controller,
              itemCount: 1,
              itemExtent: GlobalData.scrollHeight,
              itemBuilder: (BuildContext context, int index) {
                print("ListView of _MainViewState build...");
                return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Stack(
                      children: [
                        _headerView,
                        _contentView,
                        _focusWidget,
                      ],
                    ));
              }),
        ));
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
      RawKeyDownEvent rawKeyDownEvent = event;
      RawKeyEventDataAndroid rawKeyEventDataAndroid = rawKeyDownEvent.data;
      WidgetModel preFocusWidgetModel = _focusWidget.getCurFocusWidgetModel();
      // Check whether child view will handle current key event.
      if (!_hasFocusControl) {
        if (_contentView.handleKeyEvent(rawKeyEventDataAndroid.keyCode)) {
          // Child view handled so return directly.
          return;
        } else {
          // Change focus owner to main view.
          _hasFocusControl = true;
          _contentView.blur();
        }
      }

      // Get next focused widget model's id.
      int newId = -1;
      switch (rawKeyEventDataAndroid.keyCode) {
        case KeyCode.up:
          newId = preFocusWidgetModel.upId;
          break;
        case KeyCode.down:
          newId = preFocusWidgetModel.downId;
          break;
        case KeyCode.left:
          newId = preFocusWidgetModel.leftId;
          break;
        case KeyCode.right:
          newId = preFocusWidgetModel.rightId;
          break;
        default:
          break;
      }

      MainViewModel mainViewModel = BlocProvider.of<MainViewModel>(context);
      // Get next focused widget model and notify UI to update.
      WidgetModel curFocusWidgetModel;
      if (newId >= 6) {
        curFocusWidgetModel = _contentView.getWidgetModelById(newId);
        _focusWidget.updateFocusModel(curFocusWidgetModel);
        mainViewModel.focusSink.add(newId);
        // Check whether child view will control focus.
        if (_contentView.shouldControlFocus(curFocusWidgetModel.id)) {
          // Change focus owner to content view.
          _hasFocusControl = false;
          _contentView.focus();
        }
      } else if (newId >= 0) {
        curFocusWidgetModel = _headerView.getWidgetModelById(newId);
        _focusWidget.updateFocusModel(curFocusWidgetModel);
        mainViewModel.focusSink.add(newId);
        // Check whether tab index is changed or not.
        if (_contentView.updateTabIndex(newId)) {
          mainViewModel.tabIndexSink.add(newId);
        }
      } else {
        // Invalid widget id means no need to update UI, so just return.
        return;
      }

      // Update scroll offset and then scroll.
      print(
          "_handleKeyEvent oldId = ${preFocusWidgetModel.id}, newId = $newId, y = ${curFocusWidgetModel.area.y} h = ${curFocusWidgetModel.area.h} offset = $_scrollOffset");
      double scrollBase = GlobalData.scrollDelta + _scrollOffset;
      if (scrollBase <= curFocusWidgetModel.area.y &&
          curFocusWidgetModel.area.y + curFocusWidgetModel.area.h <=
              scrollBase + GlobalData.screenHeight) {
        // Current scroll offset is valid, no need to scroll.
        return;
      } else {
        if (preFocusWidgetModel.id < curFocusWidgetModel.id) {
          // Scroll down.
          _scrollOffset = curFocusWidgetModel.area.y - GlobalData.scrollDelta;
          if (_scrollOffset + GlobalData.screenHeight > GlobalData.scrollHeight)
            _scrollOffset = GlobalData.scrollHeight - GlobalData.screenHeight;
        } else {
          // Scroll up.
          _scrollOffset = curFocusWidgetModel.area.y +
              curFocusWidgetModel.area.h +
              GlobalData.scrollDelta -
              GlobalData.screenHeight;
          if (_scrollOffset < 0) _scrollOffset = 0;
        }
        _controller.jumpTo(_scrollOffset);
      }
    }
  }
}

// Don't use default ScrollBehavior.
class NullAnimationBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isLinux) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
