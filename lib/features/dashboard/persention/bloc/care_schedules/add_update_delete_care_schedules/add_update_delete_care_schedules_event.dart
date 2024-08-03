part of 'add_update_delete_care_schedules_bloc.dart';


abstract class AddUpdateDeleteCareScheduleEvent extends CareSchedulesEvent {
  const AddUpdateDeleteCareScheduleEvent();

  @override
  List<Object> get props => [];
}


class GetAllAgeGroupsEvent extends AddUpdateDeleteCareScheduleEvent {

  const GetAllAgeGroupsEvent();
}

class GetAllCareTypesAndAgeGroupsEvent extends AddUpdateDeleteCareScheduleEvent {
  const GetAllCareTypesAndAgeGroupsEvent();
}

class GetAllCareTypesEvent extends AddUpdateDeleteCareScheduleEvent {

  const GetAllCareTypesEvent();
}

class GetAllDailyCareTimesEvent extends AddUpdateDeleteCareScheduleEvent {

  const GetAllDailyCareTimesEvent();
}


