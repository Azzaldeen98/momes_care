

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/repositories/care_type_repozitorese.dart';
import 'package:moms_care/features/speech/domain/repositories/speech_repozitorese.dart';

class GetAllCareTypesWithItemsUseCase {
  final CareTypeRepository reostitory;

  const GetAllCareTypesWithItemsUseCase(this.reostitory);

  Future<Either<Failure,List<CareType>>> call() async {
    return await reostitory.getAll();
  }
}