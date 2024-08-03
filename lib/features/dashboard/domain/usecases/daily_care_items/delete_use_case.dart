

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/domain/repositories/daily_care_times_repozitorese.dart';
import 'package:moms_care/features/speech/domain/repositories/speech_repozitorese.dart';

class DeleteDailyCareTimesUseCase {
  final DailyCareTimesRepository reostitory;

  const DeleteDailyCareTimesUseCase(this.reostitory);

  Future<Either<Failure,Unit>> call(int id) async {
    return await reostitory.delete(id);
  }
}