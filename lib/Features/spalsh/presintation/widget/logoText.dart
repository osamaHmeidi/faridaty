import 'package:flutter/material.dart';

class logoText extends StatelessWidget {
  const logoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("FARIDATY",
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width / 9,
            fontFamily: "Erica One",
            height: 1));
  }
}
