import 'package:flutter/material.dart';


/// colors used in ReferenceUI pro
///
class ReferenceColors{
  static const Color appBarPageBackgroundColor = Color(0x88bb5577);
  static const Color viewPageBackgroundColor = Color(0x88bb3377);
  static const Color topBarTextColor = Color(0xffffffff);
  static const Color textFieldColor = Color(0x77ffffff);
  static const Color textFocusColor = Color(0xFFFF8A65);
}


/// ===========tab_bar===================
/// tab names
const String tableName0 = '  Home  ';
const String tableName1 = '  App  ';
/// tab TextStyle
const TextStyle tabBarLabelStyle =
TextStyle(fontSize: 40, color: ReferenceColors.textFieldColor, fontWeight: FontWeight.w400);

/// =======right_side_zone============
const double homeListView_itemRatio = 0.84;
const double homeListView_aspectRatio = 0.58;
const double homeListView_mainAxisSpacing = 25;

const double appListView_itemRatio = 0.84;
const double appListView_aspectRatio = 0.58;
const double appListView_mainAxisSpacing = 25;

const double movieListView_itemRatio = 1;
const double movieListView_aspectRatio = 1.4;
const double movieListView_mainAxisSpacing = 25;

/// ========flow_card transform=======
const double cardTransformScale = 1.2;


/// =======flow_set params=======
const double flowPageScrollOffset = 0.0; // 滚动目标与顶部的偏移值
const double flowPagePadding = 40.0;
const double flowPageMainSpace = 45.0;
const double flowPageCrossSpace = 22.0;
const double flowPageAspectRatio = 1.85;
const int flowPageMaxRowCount = 0;
const double flowPageScrollUnit = 0.0;
const int flowPageItemCount = 0;
const int flowPagePreCount = -1;


/// =======flow_set params=======
const EdgeInsetsGeometry horizontalPadding = EdgeInsets.fromLTRB(0, 5, 0, 5);
