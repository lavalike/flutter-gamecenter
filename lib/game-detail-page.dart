import 'package:flutter/material.dart';

import 'data-source.dart';
import 'entity/parts-entity.dart';
import 'entity/performance-entity.dart';
import 'entity/recommend-entity.dart';
import 'widgets/introduce-text.dart';

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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/window_background.png"),
          fit: BoxFit.cover,
        )),
        child: ListView(
          children: [
            buildIconNames(),
            buildDivider(),
            buildInformation(),
            buildButtons(),
            buildSnapshots(),
            buildParts(),
            buildRecommends(),
            buildPerformance(),
            buildRecommends(),
          ],
        ),
      ),
    );
  }

  Widget buildPerformance() {
    PerformanceEntity performance = DataSource.performance;
    return Container(
        margin: EdgeInsets.only(
            left: Dimens.margin, right: Dimens.margin, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(performance.title,
                style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.5,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: performance.gifs.length,
              itemBuilder: (context, index) {
                String asset = performance.gifs[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    asset,
                    fit: BoxFit.cover,
                  ),
                );
              },
            )
          ],
        ));
  }

  Widget buildRecommends() {
    RecommendEntity recommends = DataSource.recommends;
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.margin, right: Dimens.margin, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recommends.title,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 10),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3.5,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommends.recommends.length,
            itemBuilder: (context, index) {
              Recommend data = recommends.recommends[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white10,
                    ),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            data.icon,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            SizedBox(height: 5),
                            Text(data.info,
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 14)),
                          ],
                        )
                      ],
                    )),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildParts() {
    PartsEntity parts = DataSource.parts;
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.margin, right: Dimens.margin, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(parts.title,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: parts.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    commonJump(context);
                  },
                  child: Container(
                    width: 200,
                    height: 120,
                    margin: EdgeInsets.only(left: index == 0 ? 0 : 20),
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child:
                        Image.network(parts.images[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildSnapshots() {
    List<String> snapshots = DataSource.snapshots;
    return Container(
        height: 120,
        margin: EdgeInsets.only(
            left: Dimens.margin, top: 20, right: Dimens.margin, bottom: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshots.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                commonJump(context);
              },
              child: Container(
                width: 200,
                height: 120,
                margin: EdgeInsets.only(left: index == 0 ? 0 : 20),
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Image.network(snapshots[index], fit: BoxFit.cover),
              ),
            );
          },
        ));
  }

  Widget buildButtons() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.margin, right: Dimens.margin),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(3.0),
              ),
              alignment: AlignmentDirectional.center,
              width: 100,
              height: 30,
              child: Text("启动", style: TextStyle(color: Colors.white)),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(3.0),
              ),
              alignment: AlignmentDirectional.center,
              width: 100,
              height: 30,
              child: Text("评分", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInformation() {
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.margin, right: Dimens.margin, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IntroduceText(text: "评分"),
              IntroduceText(text: "3.9分", isTitle: false),
            ],
          ),
          informationDivider(),
          Column(
            children: [
              IntroduceText(text: "下载量"),
              IntroduceText(text: "132.8万", isTitle: false),
            ],
          ),
          informationDivider(),
          Column(
            children: [
              IntroduceText(text: "游戏大小"),
              IntroduceText(text: "40.9M", isTitle: false),
            ],
          ),
          informationDivider(),
          Column(
            children: [
              IntroduceText(text: "年龄"),
              IntroduceText(text: "18+", isTitle: false),
            ],
          ),
          informationDivider(),
          Column(
            children: [
              IntroduceText(text: "操作方式"),
              IntroduceText(text: "遥控器/手柄", isTitle: false),
            ],
          ),
          informationDivider(),
          Column(
            children: [
              IntroduceText(text: "版本"),
              IntroduceText(text: "2.3.2", isTitle: false),
            ],
          ),
          informationDivider(),
          Column(
            children: [
              IntroduceText(text: "开发者"),
              IntroduceText(text: "TCL", isTitle: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget informationDivider() {
    return SizedBox(
        width: 1, height: 20, child: Container(color: Colors.white10));
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.margin, right: Dimens.margin),
      height: 1,
      color: Colors.white10,
    );
  }

  Widget buildIconNames() {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimens.margin,
          top: Dimens.margin,
          right: Dimens.margin,
          bottom: 20),
      child: Row(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                "https://www.itying.com/images/flutter/3.png",
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            ),
            margin: EdgeInsets.only(right: 20),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DataSource.gameName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  DataSource.gameIntroduce,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void commonJump(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GameDetailsPage();
    }));
  }
}
