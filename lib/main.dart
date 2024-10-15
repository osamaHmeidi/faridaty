import 'package:faridaty/Core/shared/localNotification.dart';
import 'package:faridaty/Core/shared/locator.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/services/nearMousqueImp.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/services/prayerTimeImp.dart';
import 'package:faridaty/Features/prayerTime/presintation/viewModel/cubit/NearMousque/near_mousque_cubit.dart';
import 'package:faridaty/Features/prayerTime/presintation/viewModel/cubit/NextPrayer/cubit/next_prayer_cubit.dart';
import 'package:faridaty/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';


import 'Features/prayerTime/presintation/viewModel/cubit/PrayersTime/pryers_time_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
  await Locator.setupLocator();
   Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (dcontext) => PryersTimeCubit(PrayerTimeServicesImp())),
        BlocProvider(
            create: (dcontext) => NextPrayerCubit(PrayerTimeServicesImp())),
            BlocProvider(
            create: (dcontext) => NearMousqueCubit(NearMousqueServicesImp())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

void callbackDispatcher() async {

  Workmanager().executeTask((task, inputData) {
    
    final shPref = Locator.getIt<SharedPreferences>();
   final nextPrayerCubit = Locator.getIt<NextPrayerCubit>();
    nextPrayerCubit.getNextPrayerData(shPref.getString("city")!);
    
    return Future.value(true);
  });
}
