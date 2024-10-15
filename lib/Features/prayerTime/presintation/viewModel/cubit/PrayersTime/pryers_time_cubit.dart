import 'package:bloc/bloc.dart';
import 'package:faridaty/Core/shared/checkInternet.dart';
import 'package:faridaty/Core/shared/enResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Core/shared/showSnackBar.dart';
import '../../../../data/dynamic/services/prayerTimeImp.dart';
import '../NextPrayer/cubit/next_prayer_cubit.dart';

part 'pryers_time_state.dart';

class PryersTimeCubit extends Cubit<PryersTimeState> {
  PryersTimeCubit(this.services) : super(PryersTimeInitial());

  final PrayerTimeServicesImp services;

  Future<String> getCityNameFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality ?? "";
      } else {
        return "";
      }
    } catch (e) {
      throw Exception("Failed to get city name: $e");
    }
  }

  Future<void> fetchCityName(
      BuildContext context, SharedPreferences shPref) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      var result = await services.getPrayersTime("Mecca");
      final cData = await shPref.getStringList("prayerTimes");
      final cCity = await shPref.getString("city");

      result.fold((error) async {
        if (error == EnResponse.ConnectionError) {
          if (cData != null) {
            emit(PryersTimeSucsses(cData, true, cCity!, false));
            await context.read<NextPrayerCubit>().getNextPrayerData(cCity);
          } else {
            emit(PryersTimeConnexionFaliure());
          }
          showCustomSnackbar(context, "check the internet connection");
        } else {
          emit(PryersTimeFaliure(error.toString()));
        }
      }, (data) async {
        await context.read<NextPrayerCubit>().getNextPrayerData("Mecca");
        emit(PryersTimeSucsses(cData!, true, "Mecca", false));
        await shPref.setString("city", "Mecca");
        showCustomSnackbar(context,
            "location permission denies \n you are on the degult mode -Mecca- ");
      });

      return;
    }

    if (await checkInternet()) {
      Position position = await Geolocator.getCurrentPosition();
      String cityName = await getCityNameFromPosition(position);
      // await getCity(context); // Replace with actual city name fetch logic
      var result = await services.getPrayersTime(cityName);
      final cData = await shPref.getStringList("prayerTimes");

      result.fold((error) {}, (data) async {
        await context.read<NextPrayerCubit>().getNextPrayerData(cityName);
        await shPref.setString("city", cityName);
        emit(PryersTimeSucsses(cData!, true, cityName, false));
      });
    } else {
      final cData = await shPref.getStringList("prayerTimes");
      final cCity = await shPref.getString("city");
      if (cData != null) {
        emit(PryersTimeSucsses(cData, true, cCity!, false));
        await context.read<NextPrayerCubit>().getNextPrayerData(cCity);
      } else {
        emit(PryersTimeConnexionFaliure());
      }
      showCustomSnackbar(context, "check the internet connection");
    }
  }

  getPrayersTime(BuildContext context) async {
    final shPref = await SharedPreferences.getInstance();
    emit(PryersTimeLoading());
    bool isEnabeld = await Geolocator.isLocationServiceEnabled();
    if (!isEnabeld) {
      var result = await services.getPrayersTime("Mecca");
      final cData = await shPref.getStringList("prayerTimes");
      final cCity = await shPref.getString("city");

      result.fold((error) async {
        if (error == EnResponse.ConnectionError) {
          if (cData != null) {
            emit(PryersTimeSucsses(cData, true, cCity!, false));
            await context.read<NextPrayerCubit>().getNextPrayerData(cCity);
          } else {
            emit(PryersTimeConnexionFaliure());
          }
          showCustomSnackbar(context, "check the internet connection");
        } else {
          emit(PryersTimeFaliure(error.toString()));
        }
      }, (data) async {
        emit(PryersTimeSucsses(cData!, false, "Mecca", false));
        await context.read<NextPrayerCubit>().getNextPrayerData("Mecca");
        await shPref.setString("city", "Mecca");
        showCustomSnackbar(context,
            "location services disenabeld \n you are on the degult mode -Mecca- ");
      });
    } else {
      await fetchCityName(context, shPref);
    }
  }
}
