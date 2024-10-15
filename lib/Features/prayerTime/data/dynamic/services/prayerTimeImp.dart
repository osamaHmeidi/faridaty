import 'package:dartz/dartz.dart';
import 'package:faridaty/Core/constant/links.dart';
import 'package:faridaty/Core/shared/apiServices.dart';
import 'package:faridaty/Core/shared/detectPrayerNext.dart';
import 'package:faridaty/Core/shared/enResponse.dart';
import 'package:faridaty/Core/shared/handleData.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/prayer.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/prayerTime.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/services/prayerTime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Core/shared/getPrayerTimeModel.dart';
import '../models/enPrayerNext.dart';

class PrayerTimeServicesImp extends PrayertimeServices {
  ApiServices apiServices = ApiServices();

  @override
  Future<Either<EnResponse, PrayerTimeModel>> getPrayersTime(city) async {
    
    var response = await apiServices.getRequest(
        "${AppLinks.pPrayerTime}$city",token: AppLinks.pToken);
    
    EnResponse status = handleData(response);

    if (status == EnResponse.Sucsses) {
      if (response["status_description"] == "Success.") {
        
        PrayerTimeModel prayersTime = PrayerTimeModel
            .fromDateFor202472Fajr350AmShurooq524AmDhuhr1220PmAsr344PmMaghrib715PmIsha845Pm(
                response);
        //PrayerTimeModel p = PrayerTimeModel(dateFor: "2",fajr: "f",asr: "s",dhuhr: "d");
        List<String> prayersTimeList = [
          prayersTime.fajr.toString(),
          prayersTime.dhuhr.toString(),
          prayersTime.asr.toString(),
          prayersTime.maghrib.toString(),
          prayersTime.isha.toString()
        ];
        final shPref = await SharedPreferences.getInstance();
         await shPref.setStringList("prayerTimes",prayersTimeList);
          
    

        
        return Right(prayersTime);
      }
      return Left(status);
    } else {
      
      return Left(status);
    }
    //return Left(status);
  }

  @override
  Future<PrayerModel> getNextPrayerModel() async {
    //
    final shPref = await SharedPreferences.getInstance();
    final sList = await shPref.getStringList("prayerTimes");
    EnPrayerNext nextPrayer = detectNextPrayer(sList!);
    return getPrayerModel(nextPrayer,sList);
  }
}
