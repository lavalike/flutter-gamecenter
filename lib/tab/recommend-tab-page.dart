import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data-source.dart';
import '../entity/focus-color.dart';
import '../entity/recommend-entity.dart';
import '../game-detail-page.dart';

/// recommend-tab-page
/// @author: zhen51.wang
/// @date: 2023/1/5/005
class RecommendTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendTabState();
  }
}

class _RecommendTabState extends State<RecommendTab> {
  List<FocusNode> focusNodes = new List();
  List<FocusColor> focusColors = new List();
  var _dailyResponse = "No Daily Words";

  @override
  void dispose() {
    super.dispose();
    focusNodes.forEach((node) {
      node?.dispose();
    });
  }

  @override
  void initState() {
    super.initState();
    requestDailyWord();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DataSource.gameName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(DataSource.gameType,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                )),
          ),
          SizedBox(
            width: window.physicalSize.width / 4,
            child: Text(DataSource.gameIntroduce,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              _dailyResponse,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          ),
          _buildRecommendGames(),
        ],
      ),
    );
  }

  Widget _buildRecommendGames() {
    List<Recommend> list = DataSource.recommends.recommends;
    for (int i = 0; i < list.length; i++) {
      FocusNode node = FocusNode();
      node.addListener(() {
        if (node.hasFocus) {
          focusColors[i].background = Colors.white;
          focusColors[i].font = Colors.black;
        } else {
          focusColors[i].background = Colors.transparent;
          focusColors[i].font = Colors.white;
        }
        setState(() {
          focusColors = focusColors;
        });
      });
      focusColors.add(FocusColor(Colors.transparent, Colors.white));
      focusNodes.add(node);
    }
    return Container(
      margin: EdgeInsets.only(top: Dimens.margin / 2),
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          Recommend data = list[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GameDetailsPage();
              }));
            },
            child: RawKeyboardListener(
              focusNode: focusNodes[index],
              onKey: (RawKeyEvent event) =>
                  eventHandler(event, focusNodes[index]),
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: getDecoration(focusColors[index].background),
                margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        data.icon,
                        width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        data.name,
                        style: TextStyle(
                          color: focusColors[index].font,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Decoration getDecoration(Color color) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        shape: BoxShape.rectangle);
  }

  void eventHandler(RawKeyEvent event, FocusNode node) {
    if (event is RawKeyEvent && event.data is RawKeyEventDataAndroid) {
      RawKeyEventDataAndroid dataAndroid = event.data;
      print("keyCode: ${dataAndroid.keyCode}");
      switch (dataAndroid.keyCode) {
        case 19: // up
          print("press up");
          break;
        case 20: // down
          print("press down");
          break;
        case 21: // left
          print("press left");
          break;
        case 22: // right
          print("press right");
          break;
        case 23: // ok
        case 66: // enter
          print("press enter/ok");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GameDetailsPage();
          }));
          break;
      }
    }
  }

  void requestDailyWord() async {
    var client = HttpClient();
    var request =
        await client.getUrl(Uri.parse("http://open.iciba.com/dsapi/"));
    var response = await request.close();
    var result;
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      result = data["content"];
    } else {
      result = response.reasonPhrase;
    }
    setState(() {
      _dailyResponse = result;
    });
  }
}
