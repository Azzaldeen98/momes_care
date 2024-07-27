

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/auth/domain/repositories/auth_repostitorise.dart';

class RefreshFcmTokenUseCase{
  final AuthRepository _repository;
  RefreshFcmTokenUseCase(this._repository);

  @override
  Future<Either<Failure,Unit>> call(String fcmToken) async {
    return  await _repository.refreshFCMToken(fcmToken);
  }
}