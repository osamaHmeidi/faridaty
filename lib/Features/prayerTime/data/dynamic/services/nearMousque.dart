

import 'package:dartz/dartz.dart';
import 'package:faridaty/Core/shared/enResponse.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/nearMousque.dart';


abstract class NearMousqueServices {

  Future<Either<EnResponse,NearMousqueModel>> getNearMousque(double lat,double long);
}