

import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';


class AddDailyCareTimesEvent extends AddUpdateDeleteCareScheduleEvent {
  final DailyCareTimes dailyCareTimes ;
  const AddDailyCareTimesEvent({required this.dailyCareTimes});
}
class UpdateDailyCareTimesEvent extends AddUpdateDeleteCareScheduleEvent {
  final DailyCareTimes dailyCareTimes ;
  const UpdateDailyCareTimesEvent({required this.dailyCareTimes});
}

class DeleteDailyCareTimesEvent extends AddUpdateDeleteCareScheduleEvent {
  final int id ;
  const DeleteDailyCareTimesEvent({required this.id});
}

