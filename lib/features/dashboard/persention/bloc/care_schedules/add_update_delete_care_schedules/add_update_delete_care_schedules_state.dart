part of 'add_update_delete_care_schedules_bloc.dart';

abstract class AddUpdateDeleteCareScheduleState extends CareSchedulesState {
  const AddUpdateDeleteCareScheduleState();
}

class AddUpdateDeleteCareScheduleInitial extends AddUpdateDeleteCareScheduleState {}

//!loading
class LoadingCareSchedulesItemsState extends AddUpdateDeleteCareScheduleState {
  const LoadingCareSchedulesItemsState();

}
class LoadingAddUpdateDeleteCareScheduleState extends AddUpdateDeleteCareScheduleState {
  const LoadingAddUpdateDeleteCareScheduleState();
}

class AddUpdateDeleteCareScheduleSuccessfulState extends AddUpdateDeleteCareScheduleState {
  final String message;
  final CareScheduleItems careScheduleItem;
  const AddUpdateDeleteCareScheduleSuccessfulState({required this.message,required  this.careScheduleItem});
}
class LoadedAgeGroupsAndCareTypesState extends AddUpdateDeleteCareScheduleState {
  final List<AgeGroup> ageGroups;
  final List<CareType> careTypes;
  const LoadedAgeGroupsAndCareTypesState({required this.ageGroups,required this.careTypes});
}
//!Error
class ErrorAddUpdateDeleteCareScheduleState extends AddUpdateDeleteCareScheduleState {
  final String message;
  const ErrorAddUpdateDeleteCareScheduleState({required this.message});
}



