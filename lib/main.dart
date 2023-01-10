import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
