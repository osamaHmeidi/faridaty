part of 'pryers_time_cubit.dart';

@immutable
sealed class PryersTimeState {}

final class PryersTimeInitial extends PryersTimeState {}

final class PryersTimeSucsses extends PryersTimeState {
  final List<String> prayersTime;
  final bool isLocationServiceEnabled;
  final String cityName;
  final bool isLoading;

   PryersTimeSucsses(this.prayersTime, this.isLocationServiceEnabled, this.cityName, this.isLoading);
}

final class PryersTimeFaliure extends PryersTimeState {
  final String errorMEssage;

  PryersTimeFaliure(this.errorMEssage);
}

final class PryersTimeLoading extends PryersTimeState {}

final class PryersTimeConnexionFaliure extends PryersTimeState {}
