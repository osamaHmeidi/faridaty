import 'package:faridaty/Features/prayerTime/presintation/viewModel/cubit/NearMousque/near_mousque_cubit.dart';
import 'package:faridaty/Features/prayerTime/presintation/widget/prayerTimeCard.dart';
//import 'package:faridaty/Features/prayerTime/presintation/widget/prayerTimeStack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/dynamic/services/prayerTimeImp.dart';
import '../../data/static/prayerCardList.dart';
import '../prayerTime.dart';
import '../viewModel/cubit/PrayersTime/pryers_time_cubit.dart';

class prayersTimeGridView extends StatelessWidget {
  const prayersTimeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20,
          ),
          BlocBuilder<NearMousqueCubit, NearMousqueState>(
            builder: (context, state) {
              if (state is NearMousqueSucsses){
                return ContainerNearestMosque(distance: "${state.distanceInKm.substring(0,4)}",);
              } else if (state is NearMousqueFaliure) {
                return ContainerNearestMosque(distance: "error",);
              } else if (state is NearMousqueError) {
                return ContainerNearestMosque(distance: "error",);
              } else {
                return ContainerNearestMosque(distance: "....",);
              }
            },
          ),
          SizedBox(height: 5),
          Gridview()
        ],
      ),
    );
  }
}

class ContainerPrayerLeftTime extends StatelessWidget {
  const ContainerPrayerLeftTime(
      {super.key, required this.prayerName, required this.leftTime});

  final String prayerName;
  final String leftTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 12),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.access_time, color: Colors.white),
            SizedBox(width: 10),
            Text(
              '$prayerName in $leftTime',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerNearestMosque extends StatelessWidget {
  const ContainerNearestMosque({super.key, required this.distance});
  final String distance; 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.mosque_sharp, color: Colors.green),
          SizedBox(width: 10),
          Text(
            'the nearest mousque is on $distance KM',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width / 26),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}

class Gridview extends StatelessWidget {
  const Gridview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PryersTimeCubit, PryersTimeState>(
      builder: (context, state) {
        if (state is PryersTimeLoading) {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        } else if (state is PryersTimeSucsses) {
          if (!state.isLocationServiceEnabled) {
            Future.delayed(Duration.zero, () {
              showDefultDialog(context);
            });
          }
          return SizedBox(
            height: 300,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 1,
                    childAspectRatio: 2),
                itemCount: prayerTimeCardList.length,
                itemBuilder: (context, index) {
                  return PrayerTimeCard(
                      prayerTimeCardList[index][0],
                      '${state.prayersTime[index]}',
                      prayerTimeCardList[index][1],
                      prayerTimeCardList[index]
                          [2]); //prayerTimeCardList[index].;
                }),
          );
        } else if (state is PryersTimeConnexionFaliure) {
          return Container(
              height: MediaQuery.of(context).size.height / 3,
              child: const Center(
                child: Icon(
                  Icons.error,
                  size: 40,
                ),
              ));
        } else {
          return Center(
            child: Text("some error"),
          );
        }
      },
    );
  }
}
