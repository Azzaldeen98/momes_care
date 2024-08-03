

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/repositories/age_group_repozitorese.dart';



class UpdateAgeGroupUseCase {
  final AgeGroupRepository reostitory;

  const UpdateAgeGroupUseCase(this.reostitory);

  Future<Either<Failure,Unit>> call(AgeGroup entity) async {
    return await reostitory.update(entity);
  }
}