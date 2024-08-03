import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';

abstract class AgeGroupRepository {
  Future<Either<Failure,List<AgeGroup>>> getAll();
  Future<Either<Failure, List<AgeGroup>>> getAllWithAgeGroup();
  Future<Either<Failure,Unit>> create(AgeGroup entity);
  Future<Either<Failure,Unit>> update(AgeGroup entity);
  Future<Either<Failure,Unit>> delete(int id);
}
