import 'package:bloc/bloc.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/services/nearMousqueImp.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'near_mousque_state.dart';

class NearMousqueCubit extends Cubit<NearMousqueState> {
  NearMousqueCubit(this.services) : super(NearMousqueInitial());

  final NearMousqueServicesImp services;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Return the current position if permissions are granted
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  String calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    // Distance in meters
    double distanceInMeters = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );

    // Convert meters to kilometers
    double distanceInKm = distanceInMeters / 1000;

    // Convert the double to a string
    String numberStr = distanceInKm.toString();

    // Check if there are at least five digits
    if (numberStr.length >= 5) {
      // Get the first five digits
      String firstFiveDigits = numberStr.substring(0, 5);
    } else {}
    return numberStr;
  }

  getNearMousqueDistanceKM() async {
    emit(NearMousqueLoading());

    Position position = await determinePosition();

    // Extract latitude and longitude
    double latitude = position.latitude;
    double longitude = position.longitude;

    var result = await services.getNearMousque(latitude, longitude);

    result.fold((error) async {
      emit(NearMousqueError());
    }, (data) async {
      String distanceKM =
          calculateDistance(latitude, longitude, data.lat!, data.long!);

      emit(NearMousqueSucsses(distanceInKm: distanceKM));
    });
  }
}
