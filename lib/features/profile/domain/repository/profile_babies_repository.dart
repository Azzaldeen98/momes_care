
import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';
import '../../../forum/domain/entities/Post.dart';
import '../../data/models/profile_model.dart';

abstract class BabiesRepository{

  Future<Either<Failure,List<Baby>>> getAllBabies();
  Future<Either<Failure,Baby>> getBaby(int id);
  Future<Either<Failure,Unit>> createBaby(Baby baby);
  Future<Either<Failure,Unit>> updateBaby(Baby baby);
  Future<Either<Failure,Unit>> deleteBaby(int id);

}