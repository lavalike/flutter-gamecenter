import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t2/GlobalData.dart';
import 'package:flutter_t2/widgets/IntroduceText.dart';

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
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.margin, right: Dimens.margin),
      child: Row(
        children: [
          InkWell(
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
          InkWell(
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
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/game_icon.png"),
            ),
            margin: EdgeInsets.only(right: 10),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  GlobalData.gameName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  GlobalData.gameIntroduce,
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
}
