

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/repositories/care_schedules_repository.dart';


class GetAllAgeGroupsAndCareTypesUseCase {
  final CareSchedulesRepository reostitory;

  const GetAllAgeGroupsAndCareTypesUseCase(this.reostitory);


  Future<Either<Failure,Tuple2<List<AgeGroup>, List<CareType>>>> call() async {
    return await reostitory.getAllAgeGroupsAndCareTypes();
  }
}
