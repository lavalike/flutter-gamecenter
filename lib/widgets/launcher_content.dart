import 'package:flutter/material.dart';

import '../common/images_url.dart';
import '../common/ui_param.dart';
import '../focus_manager/tcl_focus_manager.dart';
import 'horizontal_post_list.dart';

class LauncherContent extends TFocusWidget {
  final double circleRadius = 70;

  @override
  Widget build(BuildContext context) {
    var channelZone = ChannelZone();
    focusParam.nodeList.add(channelZone);
    return channelZone;
  }
}

class ChannelZone extends TFocusWidget {
  final List<Image> homeImages = [];
  final List<Image> appImages = [];
  final List<Image> movieImages = [];

  ChannelZone() {
    homeImages.clear();
    appImages.clear();
    movieImages.clear();
    homeUris.forEach((uri) {
      homeImages.add(Image.asset(uri, fit: BoxFit.fill));
    });

    appUris.forEach((uri) {
      appImages.add(Image.asset(uri, fit: BoxFit.fill));
    });

    for (var i = 0; i < 20; ++i) {
      movieUris.add("images/movie${i + 1}.webp");
    }
    var homeListView = HorizontalPostList(
      itemRatio: homeListView_itemRatio,
      aspectRatio: homeListView_aspectRatio,
      imageUris: homeUris,
      mainAxisSpacing: homeListView_mainAxisSpacing,
    );

    var appListView = HorizontalPostList(
      itemRatio: appListView_itemRatio,
      aspectRatio: appListView_aspectRatio,
      imageUris: appUris,
      mainAxisSpacing: appListView_mainAxisSpacing,
    );

    var movieListView = HorizontalPostList(
      itemRatio: movieListView_itemRatio,
      aspectRatio: movieListView_aspectRatio,
      imageUris: movieUris,
      mainAxisSpacing: movieListView_mainAxisSpacing,
    );

    focusParam.stepV = 1;
    focusParam.nodeList.clear();
    focusParam.nodeList.add(homeListView);
    focusParam.nodeList.add(appListView);
    focusParam.nodeList.add(movieListView);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ReferenceColors.viewPageBackgroundColor,
      child: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              LayoutBuilder(builder: (context, constraints) {
                var radius = constraints.maxHeight * 0.5 * 0.5;
                return Padding(
                    padding: EdgeInsets.all(radius),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/app-store.webp"),
                      radius: radius,
                    ));
              }),
              Expanded(child: focusParam.nodeList[0] as Widget)
            ],
          )),
          Expanded(
              child: Row(
            children: <Widget>[
              LayoutBuilder(builder: (context, constraints) {
                var radius = constraints.maxHeight * 0.5 * 0.5;
                return Padding(
                    padding: EdgeInsets.all(radius),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/app-tbrowser.webp"),
                      radius: radius,
                    ));
              }),
              Expanded(child: focusParam.nodeList[1] as Widget)
            ],
          )),
          Expanded(
              child: Row(
            children: <Widget>[
              LayoutBuilder(builder: (context, constraints) {
                var radius = constraints.maxHeight * 0.5 * 0.5;
                return Padding(
                    padding: EdgeInsets.all(radius),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/app-tcast.webp"),
                      radius: radius,
                    ));
              }),
              Expanded(child: focusParam.nodeList[2] as Widget)
            ],
          )),
        ],
      ),
    );
  }
}
