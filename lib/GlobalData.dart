import 'package:flutter_t2/entity/PartsEntity.dart';
import 'package:flutter_t2/entity/RecommendEntity.dart';

/// GlobalData
/// @author: zhen51.wang
/// @date: 2023/1/5/005
class GlobalData {
  static final String gameName = "有乐斗地主";
  static final String gameIntroduce =
      "有乐斗地主，中国第一款真正的电视棋牌斗地主。采用独家原创的电视操作交互体验，由有乐游戏公司出品，该游戏基于电视遥控器深度定制。使用遥控器方向、确定、返回以及菜单键，即可轻松玩转，让你享受窝在沙发里打牌的轻松愉悦！";

  static final List<String> snapshots = [
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
  ];

  static final PartsEntity parts = PartsEntity("游戏配件", [
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
    "assets/images/game_icon.png",
  ]);

  static final RecommendEntity recommends = RecommendEntity("大家都在玩", [
    Recommend("assets/images/game_icon.png", "英雄联盟手游", "2.0万人在玩"),
    Recommend("assets/images/game_icon.png", "FIFA", "1.4万人在玩"),
    Recommend("assets/images/game_icon.png", "火影忍者", "1.8万人在玩"),
    Recommend("assets/images/game_icon.png", "QQ飞车", "2.0万人在玩"),
    Recommend("assets/images/game_icon.png", "和平精英", "1.6万人在玩"),
    Recommend("assets/images/game_icon.png", "王者荣耀", "1.3万人在玩"),
  ]);
}

class Dimens {
  static final double margin = 40;
}
