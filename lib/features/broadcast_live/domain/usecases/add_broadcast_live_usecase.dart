
import 'package:dartz/dartz.dart';



import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import '../repositories/broadcast_live_repository.dart';

class AddBroadcastLiveUseCase {
  
  final BroadcastLivesRepository _repository;

  AddBroadcastLiveUseCase(this._repository);
  
  @override
  Future<Either<Failure,Unit>> call(BroadcastLive broadcast) async {
    return await _repository.addBroadcastLive(broadcast);
  }
  
}