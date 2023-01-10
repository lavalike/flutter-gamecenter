import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../common/ui_param.dart';
import '../../focus_manager/tcl_focus_manager.dart';
import '../../widgets/flow_widget/flow_card.dart';

// 瀑布流中电影流组件m * n的表格布局，拥有滚动控组件、焦点组件（唯一焦点用来监听按键，内部实现假焦点）
class FlowSet extends StatefulWidget with TFocusNode {
  final int columnCount; // 列数
  //final int itemCount; // 瀑布流容量
  final int maxCacheSize; // 图片缓存最大个数
  final ScrollController scrollController;
  final Future<List<Widget>> Function() retrieveData;
  final int timeoutMs;

  FlowSet({
    Key key,
    this.columnCount = 3,
    this.maxCacheSize,
    this.scrollController,
    this.retrieveData,
    this.timeoutMs = 3000,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    var _flowSetState = FlowSetState();
    focusParam.nodeList.add(_flowSetState);
    return _flowSetState;
  }
}

class FlowSetState extends State<FlowSet> with TFocusNode {
  List<Widget> _items = [];
  double _scrollOffset = flowPageScrollOffset; // 滚动目标与顶部的偏移值
  double _padding = flowPagePadding;
  double _mainSpace = flowPageMainSpace;
  double _crossSpace = flowPageCrossSpace;
  double _aspectRatio = flowPageAspectRatio;
  int _maxRowCount = flowPageMaxRowCount;
  double _scrollUnit = flowPageScrollUnit;
  int _itemCount = flowPageItemCount;
  int _preCount = flowPagePreCount;

  @override
  void initState() {
    focusParam.stepH = 1;
    focusParam.stepV = widget.columnCount;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("PostFrameCallback");
      Size boxSize = (context.findRenderObject() as RenderBox).size;
      double childBoxWidth = (boxSize.width -
              2 * _padding -
              (widget.columnCount - 1) * _crossSpace) /
          widget.columnCount;
      double childBoxHeight = childBoxWidth / _aspectRatio;
      _scrollUnit = childBoxHeight + _mainSpace;
      _maxRowCount = boxSize.height ~/ (childBoxHeight + _mainSpace);
    });
    retrieveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("flow set build");
    return Container(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(_padding),
          itemCount: _itemCount,
          controller: widget.scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.columnCount,
              mainAxisSpacing: _mainSpace,
              crossAxisSpacing: _crossSpace,
              childAspectRatio: _aspectRatio),
          itemBuilder: (BuildContext context, int index) {
            // Need to load more item.
            if (index > _preCount) {
              var movieCard = PostCard(
                index: index,
                child: _items[index],
              );
              _preCount++;
              focusParam.nodeList[index] = movieCard;
              return movieCard;
            } else {
              return focusParam.nodeList[index] as Widget;
            }
          }),
    );
  }

  void retrieveData() {
    print("load data...");
    if (widget.retrieveData == null) return;
    widget
        .retrieveData()
        .timeout(Duration(milliseconds: widget.timeoutMs))
        .then((List<Widget> addList) {
      _items.addAll(addList);
      focusParam.nodeList.length += addList.length;
      setState(() {
        _itemCount = _items.length;
      });
    }, onError: (e) {
      print('fail to retrieve data: $e');
    });
  }

  // 返回实际移动的距离
  double scrollUp(double distance) {
    return setOffset(_scrollOffset - distance);
  }

  // 返回实际移动的距离
  double scrollDown(double distance) {
    return setOffset(_scrollOffset + distance);
  }

  void scrollTop() {
    setOffset(0);
  }

  // 设置当前offset，并滚动到指定offset
  double setOffset(double offset) {
    double fact = offset - _scrollOffset;

    if (offset < 0) {
      fact = 0 - _scrollOffset;
      offset = 0;
    }
    double maxOffset = widget.scrollController.position.maxScrollExtent;
    if (offset > maxOffset) {
      fact = maxOffset - _scrollOffset;
      offset = maxOffset;
      retrieveData();
    }

    _scrollOffset = offset;
    widget.scrollController.animateTo(_scrollOffset,
        duration: Duration(milliseconds: 200), curve: Curves.easeOutExpo);
    return fact; // 返回实际移动的距离
  }

  @override
  void autoScroll() {
    var vCount = 1 + focusParam.curFocusIndex ~/ widget.columnCount;
    var offset = (vCount - _maxRowCount ~/ 2) * _scrollUnit;
    setOffset(offset);
  }

  @override
  bool towardDown() {
    focusParam.nodeList[focusParam.curFocusIndex].blur();
    focusParam.curFocusIndex += focusParam.stepV;
    if (focusParam.curFocusIndex > focusParam.nodeList.length - 1) {
      focusParam.curFocusIndex = focusParam.nodeList.length - 1;
    }
    autoScroll();
    focusParam.nodeList[focusParam.curFocusIndex].focus();
    return false;
  }
}
