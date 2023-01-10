import 'dart:collection';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
  SchedulerBinding.instance.addTimingsCallback(_onReportTimings);
}

class ReferenceUI extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      routes: {
//        '/': (context) => ReferenceUIRoute(child: ChooseDisplayRoute()),
//        '/launcher': (context) => ReferenceUIRoute(child: LauncherRoute()),
//        '/flow': (context) => ReferenceUIRoute(child: ContentFlowRoute()),
//        '/home': (context) => ReferenceUIRoute(child: AppBarRoute()),
//      },
      home: ReferenceUIRoute(child: AppBarRoute()),
    );
  }
}

const maxframes = 100; // 100 帧足够了，对于 60 fps 来说
final lastFrames = ListQueue<FrameTiming>(maxframes);
const REFRESH_RATE = 60;
const frameInterval = const Duration(
    microseconds: Duration.microsecondsPerSecond ~/ REFRESH_RATE);

void _onReportTimings(List<FrameTiming> timings) {
  // 把 Queue 当作堆栈用
  for (FrameTiming timing in timings) {
    lastFrames.addFirst(timing);
  }

  // 只保留 maxframes
  while (lastFrames.length > maxframes) {
    lastFrames.removeLast();
  }

  print("current fps: $fps");
}

double get fps {
  var lastFramesSet = <FrameTiming>[];
  for (FrameTiming timing in lastFrames) {
    if (lastFramesSet.isEmpty) {
      lastFramesSet.add(timing);
    } else {
      var lastStart =
          lastFramesSet.last.timestampInMicroseconds(FramePhase.buildStart);
      if (lastStart - timing.timestampInMicroseconds(FramePhase.rasterFinish) >
          (frameInterval.inMicroseconds * 2)) {
        // in different set
        break;
      }
      lastFramesSet.add(timing);
    }
  }
  var framesCount = lastFramesSet.length;
  var costCount = lastFramesSet.map((t) {
    // 耗时超过 frameInterval 会导致丢帧
    return (t.totalSpan.inMicroseconds ~/ frameInterval.inMicroseconds) + 1;
  }).fold(0, (a, b) => a + b);
  return framesCount * REFRESH_RATE / costCount;
}
