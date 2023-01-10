import 'package:flutter/material.dart';
import 'flow_card.dart';

// 瀑布流中电影流组件m * n的表格布局，拥有滚动控组件、焦点组件（唯一焦点用来监听按键，内部实现假焦点）
class FlowSet extends StatefulWidget {
  final int columnCount; // 列数
  final int itemCount; // 瀑布流容量
  final int maxCacheSize; // 图片缓存最大个数
  final ScrollController scrollController;
  final Future<List<String>> Function() retrieveData;
  final int timeoutMs;

  FlowSet({
    Key key,
    this.columnCount = 3,
    this.maxCacheSize,
    this.scrollController,
    this.itemCount = 6,
    this.retrieveData,
    this.timeoutMs = 3000,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FlowSetState();
  }
}

class FlowSetState extends State<FlowSet> {
  final List<String> _images = [];
  final List<GlobalKey> itemKeyList = [];
  double _scrollOffset = 0; // 滚动目标与顶部的偏移值

  List<GlobalKey> getList() {
    return itemKeyList;
  }

  GlobalKey getItemKey(int index) {
    if (index > itemKeyList.length - 1) {
      return null;
    } else {
      return itemKeyList[index];
    }
  }

  @override
  void initState() {
    super.initState();
    print('flow set begin initting');
    retrieveData();
    print('init continue');
    widget.scrollController.addListener(() {
      //print('${widget.scrollController.offset}');
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        print('srcroll the max');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('movies set build');
    int count = 0;
    if (_images.length != 0) {
      count = _images.length;
    } else {
      count = 2 * widget.columnCount;
    }
    print('count = $count');
    return Scrollbar(
      child: GridView.builder(
          padding: const EdgeInsets.all(6.0),
          itemCount: count,
          controller: widget.scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.columnCount,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.7),
          itemBuilder: (BuildContext context, int index) {
            GlobalKey itemKey = GlobalKey(debugLabel: "flow card $index");
            itemKeyList.add(itemKey);
            return GridTile(
              key: itemKey,
              footer: GridTileBar(
                backgroundColor: Colors.black38,
                title: Text('title'),
                subtitle: Text('subtitle'),
                trailing: Text('trailing'),
              ),
              child: Container(
                color: Colors.black26,
                child: MovieCard(
                  url: index < _images.length ? _images[index] : null,
                ),
              ),
            );
          }),
    );
  }

  void retrieveData() {
    if (widget.retrieveData == null) return;
    widget
        .retrieveData()
        .timeout(Duration(milliseconds: widget.timeoutMs))
        .then((List<String> addList) {
      _images.addAll(addList);
      setState(() {});
    }, onError: (e) {
      print('fail to retrieve data: $e');
    });
  }

  // 返回实际移动的距离
  double scrollUp(double distance) {
    print('scroll up');
    return setOffset(_scrollOffset - distance);
  }

  // 返回实际移动的距离
  double scrollDown(double distance) {
    print('scroll down');
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
    }

    _scrollOffset = offset;
    widget.scrollController.animateTo(_scrollOffset,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
    return fact; // 返回实际移动的距离
  }
}
