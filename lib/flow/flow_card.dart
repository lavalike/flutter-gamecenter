import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String url;

  const MovieCard({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Image.network('http://192.168.88.11:80/images/home-bbc-sport.webp'),
    );
  }
}
