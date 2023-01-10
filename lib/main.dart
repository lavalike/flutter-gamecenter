import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reference_ui/fps/fps-manager.dart';

import 'routes/app_bar_route.dart';
import 'routes/reference_ui_route.dart';

void main() {
  /// Override target platform for cross-platform applications.
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
  runApp(ReferenceUI());
  SchedulerBinding.instance.addTimingsCallback(FpsManager.onReportTimings);
}

class ReferenceUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReferenceState();
  }
}

class _ReferenceState extends State<ReferenceUI> with TickerProviderStateMixin {
  /// 会重复播放的控制器
  AnimationController _repeatController;

  /// 线性动画
  Animation<double> _animation;

  Timer timer;

  @override
  void initState() {
    super.initState();

    /// 动画持续时间是 3秒，此处的this指 TickerProviderStateMixin
    _repeatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )
      ..repeat(); // 设置动画重复播放

    // 创建一个从0到360弧度的补间动画 v * 2 * π
    _animation = Tween<double>(begin: 0, end: 1).animate(_repeatController);
  }

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ReferenceUIRoute(child: AppBarRoute()),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
