import 'package:faridaty/Features/prayerTime/presintation/prayerTime.dart';
import 'package:faridaty/Features/spalsh/presintation/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: [
        GoRoute(
          path: 'prayer',
          builder: (BuildContext context, GoRouterState state) {
            return PrayerTimesScreen();
          },
        ),
      ],
    ),
  ],
);
