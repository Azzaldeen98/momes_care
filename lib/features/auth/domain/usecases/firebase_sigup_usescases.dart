import 'package:dartz/dartz.dart';

import 'package:moms_care/core/constants/enam/user_roles.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../entities/auth.dart';
import '../repositories/auth_repostitorise.dart';
import '../repositories/firebase/firebase_auth_repo.dart';

class FirebaseSignUpUseCases {
  final FirebaseAuthRepository reostitory;
  FirebaseSignUpUseCases(this.reostitory);
  Future<Either<Failure, Auth>> call({
    required String email,
    required String password,
  }) async {
    return await reostitory.signUp(
      email: email,
      password: password,
    );
  }
}
