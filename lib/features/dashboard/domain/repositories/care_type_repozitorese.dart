import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';

abstract class CareTypeRepository {
  Future<Either<Failure,List<CareType>>> getAll();
  Future<Either<Failure,List<CareType>>> getAllWithCareType();
  Future<Either<Failure,Unit>> create(CareType entity);
  Future<Either<Failure,Unit>> update(CareType entity);
  Future<Either<Failure,Unit>> delete(int id);
}
