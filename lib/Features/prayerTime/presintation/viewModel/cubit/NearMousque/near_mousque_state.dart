part of 'near_mousque_cubit.dart';

@immutable
sealed class NearMousqueState {}

final class NearMousqueInitial extends NearMousqueState {}

final class NearMousqueLoading extends NearMousqueState {}

final class NearMousqueSucsses extends NearMousqueState {
  final String distanceInKm;

  NearMousqueSucsses({required this.distanceInKm});
}

final class NearMousqueError extends NearMousqueState {}

final class NearMousqueFaliure extends NearMousqueState {}