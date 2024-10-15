import 'package:faridaty/Core/shared/splitPrayerTime.dart';
import 'package:faridaty/Features/prayerTime/data/dynamic/models/enPrayerNext.dart';


EnPrayerNext detectNextPrayer(List<String> prayersTime) {
  DateTime timeNow = DateTime.now();
  List<int> prayerTime = handlePrayerTime(prayersTime[0]);
  
  
  
      
  if (timeNow.isBefore(DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, prayerTime[0], prayerTime[1]))) {
        
    
    return EnPrayerNext.fjr;
  } 
  
  prayerTime = handlePrayerTime(prayersTime[1]);
   if (timeNow.isBefore(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      prayerTime[0],
      prayerTime[1]))) {
        
    return EnPrayerNext.dhr;
  } 
   prayerTime = handlePrayerTime(prayersTime[2]);
   if (timeNow.isBefore(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      prayerTime[0],
      prayerTime[1]))) {
        
       
    return EnPrayerNext.asr;
  } 
  
 prayerTime = handlePrayerTime(prayersTime[3]);
   if (timeNow.isBefore(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      prayerTime[0],
      prayerTime[1]))) {
        
    return EnPrayerNext.mghrb;
  } 

  prayerTime = handlePrayerTime(prayersTime[4]);
   if (timeNow.isBefore(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      prayerTime[0],
      prayerTime[1]))) {
        
    return EnPrayerNext.isha;
  } 

  return EnPrayerNext.firNextDay;
}
