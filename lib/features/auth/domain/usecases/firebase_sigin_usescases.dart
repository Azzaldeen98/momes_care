import 'package:dartz/dartz.dart';

import '../../../../core/constants/enam/user_roles.dart';
import '../../../../core/error/faiture.dart';
import '../entities/auth.dart';
import '../repositories/auth_repostitorise.dart';
import '../repositories/firebase/firebase_auth_repo.dart';

class FirebaseSignInUseCases {
  final FirebaseAuthRepository reostitory;
  FirebaseSignInUseCases(this.reostitory);
  Future<Either<Failure, Auth>> call({
    required String email,
    required String password,
  }) async {
    return await reostitory.signIn(
      email: email,
      password: password,
    );
  }
}
