

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/repositories/age_group_repozitorese.dart';
class DeleteAgeGroupUseCase {
  final AgeGroupRepository reostitory;

  const DeleteAgeGroupUseCase(this.reostitory);

  Future<Either<Failure,Unit>> call(int id) async {
    return await reostitory.delete(id);
  }
}