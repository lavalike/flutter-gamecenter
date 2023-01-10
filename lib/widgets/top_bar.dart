import 'package:flutter/material.dart';

import '../common/ui_param.dart';

class TopBar extends StatelessWidget {
  final double iconRadius = 2;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 5,
          child: TextField(
            enabled: false,
            enableInteractiveSelection: false,
            style: TextStyle(
                fontSize: 25,
                color: ReferenceColors.topBarTextColor,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration(
                labelText: "Search movies,TV and more",
                labelStyle: TextStyle(
                    fontSize: 25,
                    color: ReferenceColors.textFieldColor,
                    fontWeight: FontWeight.w400),
                hintText: "",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        Expanded(
            flex: 4,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: Transform.scale(
                    scale: iconRadius,
                    child: Icon(Icons.usb, color: ReferenceColors.topBarTextColor),
                  ),
                ),
                Expanded(
                  child: Transform.scale(
                    scale: iconRadius,
                    child: Icon(Icons.input, color: ReferenceColors.topBarTextColor),
                  ),
                ),
                Expanded(
                  child: Transform.scale(
                    scale: iconRadius,
                    child: Icon(Icons.wifi, color: ReferenceColors.topBarTextColor),
                  ),
                ),
                Expanded(
                  child: Transform.scale(
                    scale: iconRadius,
                    child: Icon(
                      Icons.settings,
                      color: ReferenceColors.topBarTextColor,
                    ),
                  ),
                )
              ],
            )),
        Spacer(
          flex: 1,
        )
      ],
    );
  }
}
