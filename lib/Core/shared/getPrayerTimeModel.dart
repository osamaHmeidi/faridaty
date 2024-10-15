import 'package:faridaty/Core/constant/links.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/enPrayerNext.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/prayer.dart';




PrayerModel getPrayerModel (EnPrayerNext nextPrayer, List<String>prayersTimeList){
  switch(nextPrayer){
    case EnPrayerNext.fjr:
    return PrayerModel(AppLinks.fjrImage,"FAJR",10, prayersTimeList[0]);
    case EnPrayerNext.firNextDay:
    return PrayerModel(AppLinks.fjrImage,"FAJR",10, prayersTimeList[0]);
    case EnPrayerNext.dhr:
    return PrayerModel(AppLinks.dhrImage,"DUHR",10,"${prayersTimeList[1]}");
    case EnPrayerNext.asr:
    return PrayerModel(AppLinks.asrImage,"ASR",10,"${prayersTimeList[2]}");
    case EnPrayerNext.mghrb:
    return PrayerModel(AppLinks.mgrbImage,"MAGHRB",10,"${prayersTimeList[3]}");
    default :
    return PrayerModel(AppLinks.ishaImage,"ISHA",10,"${prayersTimeList[4]}");
  }
}