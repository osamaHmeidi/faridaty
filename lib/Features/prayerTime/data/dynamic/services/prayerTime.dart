import 'package:dartz/dartz.dart';
import 'package:faridaty/Core/shared/enResponse.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/prayer.dart';

import '../models/prayerTime.dart';

abstract class PrayertimeServices {

 Future<Either<EnResponse,PrayerTimeModel>> getPrayersTime(String city);
 Future<PrayerModel> getNextPrayerModel();
}