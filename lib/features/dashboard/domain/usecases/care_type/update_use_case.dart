

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/domain/repositories/care_type_repozitorese.dart';
import 'package:moms_care/features/dashboard/domain/repositories/daily_care_times_repozitorese.dart';
import 'package:moms_care/features/speech/domain/repositories/speech_repozitorese.dart';

class UpdateCareTypeUseCase {
  final CareTypeRepository reostitory;

  const UpdateCareTypeUseCase(this.reostitory);

  Future<Either<Failure,Unit>> call(CareType entity) async {
    return await reostitory.update(entity);
  }
}