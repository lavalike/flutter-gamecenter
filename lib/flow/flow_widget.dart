import 'package:flutter/material.dart';

import 'flow_set.dart';
import 'focus_box.dart';

// 瀑布流组件，包括电影图片流、焦点框
class FlowWidget extends StatefulWidget {
  final int maxCacheSize;
  final int columnCount;
  final int itemCount;
  final double focusBoxBorderWidth;
  final SliverGridDelegate gridDelegate;
  final Future<List<String>> Function() retrieveDataCallback;
  final int timeoutMs;

  final _FlowWidgetState flowWidgetState = _FlowWidgetState();

  FlowWidget({
    this.columnCount,
    this.itemCount,
    this.focusBoxBorderWidth = 3.5,
    this.gridDelegate,
    this.retrieveDataCallback,
    this.timeoutMs = 3000,
    this.maxCacheSize,
  });

  @override
  State<StatefulWidget> createState() {
    return flowWidgetState;
  }

  bool handleKeyEvent(int keyCode) {
    return flowWidgetState._handleKeyEvent(keyCode);
  }

  void focus() {
    flowWidgetState.focusBoxKey.currentState.show();
  }

  void blur() {
    flowWidgetState.focusBoxKey.currentState.hide();
  }
}

class _FlowWidgetState extends State<FlowWidget> {
  ScrollController _scrollController = ScrollController(); // 瀑布流滚动控制器
  GlobalKey<FlowSetState> moviesKey = GlobalKey<FlowSetState>();
  GlobalKey<FocusBoxState> focusBoxKey =
      GlobalKey<FocusBoxState>(debugLabel: 'focusbox');

  int _maxColumnCount = 0;
  int _maxRowCount = 0;
  int _columnIndex = 0;
  int _rowIndex = 0;
  double _verticalOffset = 0.0;
  double _horizontalOffset = 0.0;

  @override
  void initState() {
    _maxColumnCount = widget.columnCount;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('post frame');
      Size widgetSize = moviesKey.currentContext.size;
      final RenderBox renderBox = moviesKey.currentContext.findRenderObject();
      Offset widgetPosition = renderBox.localToGlobal(Offset(0, 0));

      List<GlobalKey> list = moviesKey.currentState.getList();

      // 获取焦点框移动相关数据
      GlobalKey firstItemKey;
      GlobalKey secondItemKey;
      Size focusBoxSize;
      Offset firstItemPos;
      if (list == null) return;
      // 获取第一个item坐标和尺寸，初始化焦点框
      if (list.length > 0) {
        firstItemKey = list[0];
        RenderBox itemRenderBox =
            firstItemKey.currentContext.findRenderObject();
        if (itemRenderBox == null) return;
        firstItemPos = itemRenderBox.localToGlobal(Offset(0, 0));
        focusBoxSize = firstItemKey.currentContext.size;
        print('first item pos = $firstItemPos');
        print('first item size = $focusBoxSize');
        double l = firstItemPos.dx - widgetPosition.dx;
        double t = firstItemPos.dy - widgetPosition.dy;
        double r = widgetSize.width - focusBoxSize.width - l;
        double b = widgetSize.height - focusBoxSize.height - t;
        print('l $l, t $t,r $r, b $b');
        focusBoxKey.currentState.initFocusBoxInfo(
            l - widget.focusBoxBorderWidth,
            t - widget.focusBoxBorderWidth,
            r - widget.focusBoxBorderWidth,
            b - widget.focusBoxBorderWidth);
      }

      // 获取焦点框水平方向单位位移
      if (_maxColumnCount > 1 && list.length > 1) {
        secondItemKey = list[1];
        RenderBox secondRenderBox =
            secondItemKey.currentContext.findRenderObject();
        Offset secondItemOffset = secondRenderBox.localToGlobal(Offset(0, 0));
        _horizontalOffset = secondItemOffset.dx - firstItemPos.dx;
      }

      // 获取页面最大垂直位移数目、焦点框垂直方向单位位移
      _maxRowCount = widgetSize.height ~/ focusBoxSize.height - 1;
      int index = _maxColumnCount; // 第二行第一个item的下标，从0开始
      if (index < list.length) {
        var itemKey = list[index];
        RenderBox renderBox = itemKey.currentContext.findRenderObject();
        Offset offset = renderBox.localToGlobal(Offset(0, 0));
        _verticalOffset = offset.dy - firstItemPos.dy;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('flow widget build');
    return Stack(
      children: <Widget>[
        FlowSet(
          key: moviesKey,
          maxCacheSize: widget.maxCacheSize,
          columnCount: widget.columnCount,
          itemCount: widget.itemCount,
          scrollController: _scrollController,
          retrieveData: widget.retrieveDataCallback,
          timeoutMs: widget.timeoutMs,
        ),
        FocusBox(
          key: focusBoxKey,
          borderWidth: widget.focusBoxBorderWidth,
        ),
      ],
    );
  }

  bool _handleKeyEvent(int keyCode) {
    bool handledInternal = true;
    switch (keyCode) {
      case 19: //KEY_UP
        print('begin: row index = $_rowIndex, max row count = $_maxRowCount');
        if (_rowIndex > 0) {
          // 焦点框向上移动
          focusBoxKey.currentState.moveUp(_verticalOffset);
          --_rowIndex;
        } else {
          // 焦点框已经处于最上方，内容需要往上翻
          double fact = moviesKey.currentState.scrollUp(_verticalOffset).abs();
          // 调整第一行的焦点框
          if (fact > 0 && fact < _verticalOffset) {
            focusBoxKey.currentState.moveUp(_verticalOffset - fact);
          }
          if (fact == 0) handledInternal = false;
        }
        print('after: row index = $_rowIndex');
        break;
      case 20: //KEY_DOWN
        print('begin: row index = $_rowIndex, max row count = $_maxRowCount');
        if (_rowIndex < _maxRowCount - 1) {
          // 焦点框向下移动
          focusBoxKey.currentState.moveDown(_verticalOffset);
          ++_rowIndex;
        } else {
          // 焦点框已经处于最下方，内容需要往下翻
          double fact =
              moviesKey.currentState.scrollDown(_verticalOffset).abs();
          // 调整最后一行的焦点框，滚动条到达最底部
          if (fact > 0 && fact < _verticalOffset) {
            focusBoxKey.currentState.moveDown(_verticalOffset - fact);
            moviesKey.currentState.retrieveData();
          }
          if (fact == 0) moviesKey.currentState.retrieveData();
        }
        print('after: row index = $_rowIndex');
        break;
      case 21: //KEY_LEFT
        if (_columnIndex > 0) {
          // 焦点框向左边移动
          focusBoxKey.currentState.moveLeft(_horizontalOffset);
          --_columnIndex;
        } else {
          handledInternal = false;
        }
        break;
      case 22: //KEY_RIGHT
        if (_columnIndex < widget.columnCount - 1) {
          // 焦点框向右边移动
          focusBoxKey.currentState.moveRight(_horizontalOffset);
          ++_columnIndex;
        } else {
          handledInternal = false;
        }
        break;
      default:
        break;
    }
    return handledInternal;
  }
}
