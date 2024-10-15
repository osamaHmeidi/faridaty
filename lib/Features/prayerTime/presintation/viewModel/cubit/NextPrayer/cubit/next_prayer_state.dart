part of 'next_prayer_cubit.dart';

@immutable
sealed class NextPrayerState {}

final class NextPrayerInitial extends NextPrayerState {}

final class NextPrayerSucsses extends NextPrayerState {
  final PrayerModel prayerModel;
  final String cityName;
  final List<String> PrayersTime;
  NextPrayerSucsses(this.prayerModel, this.cityName, this.PrayersTime);
}

final class NextPrayerFaliure extends NextPrayerState {}
final class NextPrayerRefresh extends NextPrayerState {
   final PrayerModel prayerModel;
   final int remainTime;
   final String cityName;
    List<String> g = [""];
  NextPrayerRefresh(this.prayerModel, this.remainTime, this.cityName);
}
final class NextPrayerLoading extends NextPrayerState {}
