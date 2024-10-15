import 'package:faridaty/Features/prayerTime/data/static/dayslist.dart';
import 'package:faridaty/Features/prayerTime/data/static/monthList.dart';
import 'package:jhijri/jHijri.dart';

import '../../Features/prayerTime/data/static/hijiryMonthsList.dart';

class Timenow{

  static String getHijryDate(){

    return "${hijiryMonths[JHijri.now().month -1 ]} ${JHijri.now().day} ${JHijri.now().year}";
  }

  static String getMiladiDate(){
    
    
    
    return "${daysList[DateTime.now().weekday - 1]} ${months[DateTime.now().month -1 ]} ${DateTime.now().day} ${DateTime.now().year}";
  }
}