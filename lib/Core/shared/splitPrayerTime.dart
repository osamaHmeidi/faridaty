

List<int> handlePrayerTime(String prayerTime){
  
  
  
  List<String> timeInHourAndMi = prayerTime.split(':');
  timeInHourAndMi[1] = timeInHourAndMi[1].substring(0,2);
  List <int> timeInHourAndMiF= [int.parse(timeInHourAndMi[0]),int.parse(timeInHourAndMi[1])];// timeInHourAndM.replaceAll(RegExp(r'[\[\], ]'), '').split('').map(int.parse).toList();
  
  if (prayerTime[prayerTime.length - 2] == "p" && timeInHourAndMiF[0] != 12){
    timeInHourAndMiF[0] +=12; 
  }
  
  
  
  return  timeInHourAndMiF;
}