

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/repositories/age_group_repozitorese.dart';

class GetAllAgeGroupsWithItemsUseCase {
  final AgeGroupRepository reostitory;

  const GetAllAgeGroupsWithItemsUseCase(this.reostitory);

  Future<Either<Failure,List<AgeGroup>>> call() async {
    return await reostitory.getAll();
  }
}