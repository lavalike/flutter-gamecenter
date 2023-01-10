import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../common/images_url.dart';
import '../common/ui_param.dart';
import '../focus_manager/tcl_focus_manager.dart';
import '../widgets/flow_widget/flow_card.dart';

class HorizontalPostList extends StatefulWidget with TFocusNode {
  HorizontalPostList({
    Key key,
    this.itemExtent,
    this.imageUris,
    this.aspectRatio = 1.0,
    this.mainAxisSpacing = 0.0,
    this.itemRatio = 1.0,
  })  : assert(itemRatio <= 1.0 && itemRatio > 0),
        super(key: key);

  /// 子元素的纵横比
  final double aspectRatio;

  /// 子元素占父元素高度的百分百，必须大于0并且小于等于1
  final double itemRatio;

  /// 子元素在主轴方向的大小，同时也是滚动的单位长度
  final double itemExtent;

  /// 子元素图片集合源
  final List<String> imageUris;

  /// 主轴方向子元素的间隔大小
  final double mainAxisSpacing;

  @override
  State<StatefulWidget> createState() {
    var horizontalPostListState = HorizontalPostListState();
    horizontalPostListState.focusParam.stepH = 1;
    focusParam.nodeList.clear();
    focusParam.nodeList.add(horizontalPostListState);
    return horizontalPostListState;
  }
}

class HorizontalPostListState extends State<HorizontalPostList>
    with TFocusNode {
  var _scrollController = ScrollController();
  var _bgScrollController = ScrollController();

  // offset of each scrolling
  var _itemExtent = 0.0;

  // max count of item in the list
  var _maxValidCount = 0;

  var _itemWidth;
  var _itemHeight;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildList(bool isFg, ScrollController scrollController) {
    return ListView.builder(
        padding: horizontalPadding,
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.imageUris.length,
        itemExtent: _itemExtent,
        itemBuilder: (context, index) {
          var scaleAlignment =
              index == 0 ? Alignment.centerLeft : Alignment.center;

          var description = descriptionMap[widget.imageUris[index]];

          var post = PostCard(
            scaleAlignment: scaleAlignment,
            description: description == null ? "" : description,
            width: _itemWidth,
            height: _itemHeight,
            index: index,
            initOffStage: isFg,
            child: Image.asset(
              widget.imageUris[index],
              fit: BoxFit.fill,
            ),
          );
          if (isFg == true) {
            focusParam.nodeList.add(post);
          }

          // 返回居中的子元素
          return Align(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Container(height: _itemHeight, width: _itemWidth, child: post),
                Container(
                  height: _itemHeight,
                  width: widget.mainAxisSpacing,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _itemHeight = constraints.maxHeight * widget.itemRatio;
        _itemWidth = _itemHeight / widget.aspectRatio;
        _maxValidCount = constraints.maxWidth ~/ _itemWidth;
        _itemExtent = _itemWidth + widget.mainAxisSpacing;
        return Stack(
          children: <Widget>[
            _buildList(false, _bgScrollController),
            _buildList(true, _scrollController)
          ],
        );
      },
    );
  }

  @override
  void autoScroll() {
    double offset =
        (focusParam.curFocusIndex - 0.5 - _maxValidCount ~/ 2) * _itemExtent;
    if (offset < 0) {
      offset = 0;
    }
    if (offset > _scrollController.position.maxScrollExtent) {
      offset = _scrollController.position.maxScrollExtent;
    }
    _scrollController.animateTo(offset,
        duration: Duration(milliseconds: 150), curve: Curves.easeOutExpo);
    _bgScrollController.animateTo(offset,
        duration: Duration(milliseconds: 150), curve: Curves.easeOutExpo);
  }
}
