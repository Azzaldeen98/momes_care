

import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/persention/bloc/care_schedules/add_update_delete_care_schedules/add_update_delete_care_schedules_bloc.dart';

class AddAgeGroupEvent extends AddUpdateDeleteCareScheduleEvent {
  final AgeGroup ageGroup;
  const AddAgeGroupEvent({required this.ageGroup});
}


class UpdateAgeGroupEvent extends AddUpdateDeleteCareScheduleEvent {
  final AgeGroup ageGroup;
  const UpdateAgeGroupEvent({required this.ageGroup});
}

class DeleteAgeGroupEvent extends AddUpdateDeleteCareScheduleEvent {
  final int id ;
  const DeleteAgeGroupEvent({required this.id});
}
