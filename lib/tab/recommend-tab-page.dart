import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data-source.dart';
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
          _buildRecommendGames(),
        ],
      ),
    );
  }

  Widget _buildRecommendGames() {
    List<Recommend> list = DataSource.recommends.recommends;
    return Expanded(
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
            child: Container(
              margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
              child: Column(
                children: [
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
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
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
