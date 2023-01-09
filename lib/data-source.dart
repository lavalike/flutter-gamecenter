import 'entity/parts-entity.dart';
import 'entity/performance-entity.dart';
import 'entity/recommend-entity.dart';

/// DataSource
/// @author: zhen51.wang
/// @date: 2023/1/5/005
class DataSource {
  static final List<String> tabs = [
    "精选推荐",
    "云游戏",
    "经典手游",
  ];

  static final String gameName = "植物大战僵尸2";
  static final String gameType = "咪咕游戏 | 遥控器";
  static final String gameIntroduce =
      "游戏在抵御僵尸进攻的玩法上，新增了叶绿素、手势操作、无尽挑战、潘妮的追击等元素和玩法，玩家将可以体验到十余个玩法各异的时空地图。游戏同时集成了即时战略、塔防御战和卡片收集等要素。";

  static final List<String> snapshots = [
    "https://www.itying.com/images/flutter/1.png",
    "https://www.itying.com/images/flutter/2.png",
    "https://www.itying.com/images/flutter/3.png",
    "https://www.itying.com/images/flutter/4.png",
    "https://www.itying.com/images/flutter/5.png",
    "https://www.itying.com/images/flutter/6.png",
    "https://www.itying.com/images/flutter/7.png",
  ];

  static final PartsEntity parts = PartsEntity("游戏配件", [
    "https://www.itying.com/images/flutter/1.png",
    "https://www.itying.com/images/flutter/2.png",
    "https://www.itying.com/images/flutter/3.png",
  ]);

  static final RecommendEntity recommends = RecommendEntity("大家都在玩", [
    Recommend("assets/images/plants_vs_zombies.jpg", "英雄联盟手游", "2.0万人在玩"),
    Recommend("assets/images/plants_vs_zombies.jpg", "FIFA", "1.4万人在玩"),
    Recommend("assets/images/plants_vs_zombies.jpg", "火影忍者", "1.8万人在玩"),
    Recommend("assets/images/plants_vs_zombies.jpg", "QQ飞车", "2.0万人在玩"),
    Recommend("assets/images/plants_vs_zombies.jpg", "和平精英", "1.6万人在玩"),
    Recommend("assets/images/plants_vs_zombies.jpg", "王者荣耀", "1.3万人在玩"),
  ]);

  static final PerformanceEntity performance = PerformanceEntity("Gif性能测试", [
    "assets/images/loading.gif",
    "assets/images/loading.gif",
    "assets/images/loading.gif",
  ]);
}

class Dimens {
  static final double margin = 40;
}
