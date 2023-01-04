import 'package:flutter/material.dart';

/// GameDetailsPage
/// @author: zhen51.wang
/// @date: 2023/1/4/004
class GameDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameDetailsState();
  }
}

class _GameDetailsState extends State<GameDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Hello GameDetailsPage')],
      ),
    ));
  }
}
