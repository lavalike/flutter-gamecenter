import 'package:flutter/material.dart';

/// IntroduceText
/// @author: zhen51.wang
/// @date: 2023/1/4/004
class IntroduceText extends StatelessWidget {
  final String text;
  final bool isTitle;

  const IntroduceText({Key key, this.text, this.isTitle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.text,
        style: TextStyle(
            color: this.isTitle ? Colors.white54 : Colors.white, fontSize: 14),
      ),
    );
  }
}
