import 'package:flutter/material.dart';

class logoSplashAnimated extends StatelessWidget {
  const logoSplashAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        curve: Curves.bounceOut,
        tween: Tween(end: 0.0, begin: -100.0),
        duration: Duration(seconds: 2),
        builder: (build, value, child) {
          return Transform.translate(
              offset: Offset(value, value),
              child: Container(
                height: 80,
                width: 80,
                child: Image.asset("assets/images/faridatyLogo.png"),
              ));
        });
  }
}
