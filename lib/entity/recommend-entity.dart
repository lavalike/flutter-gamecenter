/// RecommendEntity
/// @author: zhen51.wang
/// @date: 2023/1/5/005
class RecommendEntity {
  String title;
  List<Recommend> recommends;

  RecommendEntity(this.title, this.recommends);
}

class Recommend {
  String icon;
  String name;
  String info;

  Recommend(this.icon, this.name, this.info);
}
