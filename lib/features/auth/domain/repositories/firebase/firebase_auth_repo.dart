
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../../../domain/entities/user_info.dart' as local;
import '../../entities/auth.dart';
abstract class FirebaseAuthRepository {

Future<Either<Failure,Auth>> signUp({required String email,required String password});
Future<Either<Failure,Auth>> signIn({required String email,required String password});

}
