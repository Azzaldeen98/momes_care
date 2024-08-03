import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';



import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import '../repositories/broadcast_live_repository.dart';

class UpdateBroadcastLiveUseCase {
  
  final BroadcastLivesRepository _repository;

  UpdateBroadcastLiveUseCase(this._repository);
  
  @override
  Future<Either<Failure,Unit>> call(BroadcastLive broadcast) async {
    return await _repository.updateBroadcastLive(broadcast);
  }
  
}