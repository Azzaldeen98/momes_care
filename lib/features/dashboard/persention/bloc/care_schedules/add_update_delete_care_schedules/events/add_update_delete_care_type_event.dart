

import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';

class AddCareTypeEvent extends AddUpdateDeleteCareScheduleEvent {
  final CareType careType;
  const AddCareTypeEvent({required this.careType});
}

class UpdateCareTypeEvent extends AddUpdateDeleteCareScheduleEvent {
  final CareType careType;
  const UpdateCareTypeEvent({required this.careType});
}

class DeleteCareTypeEvent extends AddUpdateDeleteCareScheduleEvent {
  final int id ;
  const DeleteCareTypeEvent({required this.id});
}
