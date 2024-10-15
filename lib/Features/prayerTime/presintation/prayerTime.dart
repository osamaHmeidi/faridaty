import 'package:faridaty/Core/shared/localNotification.dart';
import 'package:faridaty/Features/prayerTime/presintation/viewModel/cubit/NearMousque/near_mousque_cubit.dart';
import 'package:faridaty/Features/prayerTime/presintation/viewModel/cubit/NextPrayer/cubit/next_prayer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
//import '../../../Core/shared/locationservices'/getPosition.dart';
import '../../../main.dart';
import 'viewModel/cubit/PrayersTime/pryers_time_cubit.dart';
import 'widget/gridView.dart';
import 'widget/prayerTimeStack.dart';

class PrayerTimesScreen extends StatefulWidget {
  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
   
    super.initState();
    startFunction();
  }

  void startFunction()  {
    /* Position position = await getCurrentLocation();
   String cityName = await getCity(position); */
    Future.delayed(Duration.zero, () async {
      await context.read<PryersTimeCubit>().getPrayersTime(context);
      await context.read<NearMousqueCubit>().getNearMousqueDistanceKM();
    });
   
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh the location service status when the app returns to the foreground
      context.read<PryersTimeCubit>().getPrayersTime(context);
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  MultiBlocListener(
          listeners: [
            BlocListener<PryersTimeCubit,PryersTimeState>(listener: (context,state){}),
            BlocListener<NextPrayerCubit,NextPrayerState>(listener: (context,state){}),
            BlocListener<NearMousqueCubit,NearMousqueState>(listener: (context,state){})
          ],
          child: Column(
            children: [prayerTimeStack(), prayersTimeGridView()],
          ),
        ),
    );
  }
}

void showDefultDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext builder) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Locatian Services Enabeld",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "please enable to show your city times",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 25,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.black),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await Geolocator.openLocationSettings();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Go To Location Setting",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 0.2),
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
            ],
          ),
        );
      });
}
