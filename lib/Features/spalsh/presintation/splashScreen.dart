

import 'package:faridaty/Core/constant/date.dart';
import 'package:faridaty/Features/spalsh/presintation/widget/logoText.dart';
import 'package:faridaty/Features/spalsh/presintation/widget/slogan.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widget/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()   {
    //PrayerTimeServicesImp p =PrayerTimeServicesImp();
    
    Future.delayed(const Duration(seconds: 3), () async {
      
      //await p.getPrayersTime("dubai");
      context.go("/prayer");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            logoSplashAnimated(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                logoText(),
                Slogan()
              ],
            )
          ],
        ),
      )),
    );
  }
}
