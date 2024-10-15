import 'dart:ui';
import 'package:faridaty/Core/constant/timeNow.dart';
import 'package:faridaty/Core/shared/detectPrayerNext.dart';
import 'package:faridaty/Core/shared/handleRemainTime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/dynamic/services/prayerTimeImp.dart';
import '../viewModel/cubit/NextPrayer/cubit/next_prayer_cubit.dart';
import 'gridView.dart';
import 'prayerTimeImage.dart';

class prayerTimeStack extends StatelessWidget {
  const prayerTimeStack({super.key});

 

  @override
  Widget build(BuildContext context)  {
    
    return BlocBuilder<NextPrayerCubit, NextPrayerState>(
        builder: (context, state) {
      if (state is NextPrayerFaliure) {
        return Container(
          height:  MediaQuery.of(context).size.height / 4,
          child: Center(
            child: Icon(Icons.error,size: 40,),
          ),
        );
        
      } else if (state is NextPrayerSucsses || state is NextPrayerRefresh) {
      final List<String> pList = (state is NextPrayerSucsses) ? state.PrayersTime : (state as NextPrayerRefresh).g;
        final String cityName = (state is NextPrayerSucsses)
            ? state.cityName
            : (state as NextPrayerRefresh).cityName;
        final data = (state is NextPrayerSucsses)
            ? state.prayerModel
            : (state as NextPrayerRefresh).prayerModel;
        final int rTime = (state is NextPrayerRefresh)
            ? state.remainTime
            : handleRemainTime(data.time!, detectNextPrayer(pList));
        return Column(
          children: [
            Stack(
              children: [
                PrayertimeImage(image: data.image!),
                TitleLocation(cityName: cityName),
                PrayerCurrentCard(
                  preyerName: data.name!,
                  preyerTime: data.time!,
                ),
              ],
            ),
            ContainerPrayerLeftTime(
              prayerName: data.name!,
              leftTime: rTime > 59
                  ? "${(rTime / 60).toInt()} H ${rTime % 60} M"
                  : "${rTime % 60} M, get ready to go to mousque",
            ),
          ],
        );
      } else {
        return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            )));
      }
    });
  }
}

class TitleLocation extends StatelessWidget {
  const TitleLocation({super.key, required this.cityName});
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prayer time',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(right: 15, left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.6)),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 5),
                Text(
                  cityName != "" ? cityName : "MECCA",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrayerCurrentCard extends StatelessWidget {
  const PrayerCurrentCard(
      {super.key, required this.preyerName, required this.preyerTime});
  final String preyerName;
  final String preyerTime;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: MediaQuery.of(context).size.width / 12,
      right: MediaQuery.of(context).size.width / 12,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 350,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                color: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  '${Timenow.getHijryDate()}\n${Timenow.getMiladiDate()}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '$preyerName $preyerTime',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
