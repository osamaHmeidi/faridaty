import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:faridaty/Core/shared/detectPrayerNext.dart';
import 'package:faridaty/Core/shared/handleRemainTime.dart';
import 'package:faridaty/Core/shared/localNotification.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/prayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/dynamic/services/prayerTimeImp.dart';


part 'next_prayer_state.dart';

class NextPrayerCubit extends Cubit<NextPrayerState> {
  NextPrayerCubit(this.services) : super(NextPrayerInitial());

  final PrayerTimeServicesImp services;
  // ignore: unused_field
  Timer? _timer;
  dynamic _cashed;
  late int rTime;
  

  getNextPrayerData( String cityName) async {
    emit(NextPrayerLoading());
    final shPref = await SharedPreferences.getInstance();
    final cData =  shPref.getStringList("prayerTimes");
    final data = await  services.getNextPrayerModel();
    rTime = handleRemainTime(data.time!, detectNextPrayer(cData!));
    _cashed = data;
      emit(NextPrayerSucsses(data, cityName,cData));
      startPeriodicUpdate(cityName,data.name!);
    }

  void startPeriodicUpdate( String cityName,String prayerName) {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (rTime >= -1) {
        emit(NextPrayerRefresh(_cashed, rTime,cityName));
        rTime--;
      } else {
         LocalNotification.showNotification("Prayer Time","$prayerName prayer time according to local time in $cityName");
        getNextPrayerData(cityName);
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

