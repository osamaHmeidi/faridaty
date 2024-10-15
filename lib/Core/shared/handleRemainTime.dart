import 'package:faridaty/Core/constant/date.dart';
import 'package:faridaty/Core/shared/splitPrayerTime.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/enPrayerNext.dart';

int handleRemainTime(String prayerTime, EnPrayerNext prayerNext){
List<int> pt= handlePrayerTime(prayerTime);
Duration diff= DateTime(AppDate.getYear(),AppDate.getMonth(),prayerNext == EnPrayerNext.firNextDay ? AppDate.getday() + 1 : AppDate.getday(),pt[0],pt[1]).difference(DateTime.now());

return diff.inMinutes; 

}