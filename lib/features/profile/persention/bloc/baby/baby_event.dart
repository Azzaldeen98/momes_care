


import 'package:equatable/equatable.dart';

import 'package:moms_care/core/constants/enam/profile_pages.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';


abstract class BabyEvent extends Equatable {
  const BabyEvent();
  @override
  List<Object> get props => [];
}


class AddBabyEvent extends BabyEvent{
  final Baby  baby;
  const AddBabyEvent({required this.baby});
}
class UpdateBabyEvent extends BabyEvent{
  final Baby  baby;
  const UpdateBabyEvent({required this.baby});
}

class GetBabyDailyCareTimesEvent extends BabyEvent{
  final int babyId;
  const GetBabyDailyCareTimesEvent({required this.babyId});
}


class DeleteBabyEvent extends BabyEvent{
  final int id;
  const DeleteBabyEvent({required this.id});
}










