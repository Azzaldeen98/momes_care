
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moms_care/core/constants/enam/profile_pages.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';



abstract class BabyState extends Equatable {
  const BabyState();
  @override
  List<Object> get props => [];
}

class BabyInitialState extends BabyState{
  const BabyInitialState();
}

class LoadingBabiesState extends BabyState{
  const LoadingBabiesState();
}

class LoadedBabiesState extends BabyState{
  const LoadedBabiesState({required this.babies});
  final List<Baby> babies;
  @override
  List<Object> get props => [babies];
}
class LoadingBabyDailyCareTimesState extends BabyState{
  const LoadingBabyDailyCareTimesState();
}
class LoadedBabyDailyCareTimesState extends BabyState{
  const LoadedBabyDailyCareTimesState({required this.dailyCareTimes});
  final List<DailyCareTimes> dailyCareTimes;
  @override
  List<Object> get props => [dailyCareTimes];
}

class AddUpdateDeleteBabySuccessState extends BabyState{
  const AddUpdateDeleteBabySuccessState( {required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}


class ErrorBabyState extends BabyState {
  final String message;
  const ErrorBabyState({required this.message});
  @override
  List<Object> get props => [message];
}

