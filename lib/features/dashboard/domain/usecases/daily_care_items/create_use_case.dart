

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/domain/repositories/daily_care_times_repozitorese.dart';
import 'package:moms_care/features/speech/domain/repositories/speech_repozitorese.dart';





class CreateDailyCareTimesUseCase {
  final DailyCareTimesRepository reostitory;

  const CreateDailyCareTimesUseCase(this.reostitory);

  Future<Either<Failure,Unit>> call(DailyCareTimes entity) async {
    return await reostitory.create(entity);
  }
}