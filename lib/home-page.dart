import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t2/data-source.dart';
import 'package:flutter_t2/tab/classic-mobile-tab-page.dart';
import 'package:flutter_t2/tab/cloud-game-tab-page.dart';
import 'package:flutter_t2/tab/recommend-tab-page.dart';

/// home-page
/// @author: zhen51.wang
/// @date: 2023/1/5/005
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/window_background.png"),
        fit: BoxFit.cover,
      )),
      child: _homeView(),
    );
  }

  Widget _homeView() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarOpacity: 0,
        title: _tabBar(),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          RecommendTab(),
          CloudGameTab(),
          ClassicMobileTab(),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
        isScrollable: true,
        labelStyle: TextStyle(fontSize: 14),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white,
        controller: _controller,
        indicator: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
        ),
        tabs: DataSource.tabs.map((e) => Center(child: Text(e))).toList());
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
