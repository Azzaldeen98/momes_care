import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';

abstract class CareSchedulesRepository {
  Future<Either<Failure,Tuple2<List<AgeGroup>, List<CareType>>>> getAllAgeGroupsAndCareTypes();
}
