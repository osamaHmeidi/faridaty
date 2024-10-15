import 'package:faridaty/Features/prayerTime/presintation/viewModel/cubit/NextPrayer/cubit/next_prayer_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Features/prayerTime/data/dynamic/services/prayerTimeImp.dart';

class Locator{

 static final getIt = GetIt.instance;
   

static  setupLocator() async {
   final sharedPreferences = await SharedPreferences.getInstance();
  
  // Register SharedPreferences with get_it
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
getIt.registerLazySingleton<PrayerTimeServicesImp>(()=>PrayerTimeServicesImp());
  getIt.registerLazySingleton<NextPrayerCubit>(() => NextPrayerCubit(getIt<PrayerTimeServicesImp>()));
}
}