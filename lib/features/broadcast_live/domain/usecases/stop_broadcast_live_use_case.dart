
import 'package:dartz/dartz.dart';

import 'package:moms_care/core/error/faiture.dart';
import '../repositories/broadcast_live_repository.dart';

class StopBroadcastLiveUseCase {
  
  final BroadcastLivesRepository _repository;

  StopBroadcastLiveUseCase(this._repository);
  
  @override
  Future<Either<Failure,Unit>> call(int id) async {
    return await _repository.stopBroadcastLive(id);
  }
  
}