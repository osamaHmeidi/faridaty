import 'package:flutter/material.dart';

class Slogan extends StatelessWidget {
  const Slogan({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "your prayer on time",
      style: TextStyle(
          color: Color(0xff00CFAA),
          fontSize: MediaQuery.of(context).size.width / 23,
          fontFamily: "Erica One"),
    );
  }
}
