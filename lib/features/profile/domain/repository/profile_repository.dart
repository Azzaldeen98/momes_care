
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../../../forum/domain/entities/Post.dart';
import '../../data/models/profile_model.dart';







abstract class ProfileRepository{

  Future<Either<Failure,Profile>> refreshProfileInfo();
  Future<Either<Failure,Profile>> getProfileInfo();
  Future<Either<Failure,List<Post>>> getMyPosts();
  Future<Either<Failure,Unit>> updateName(String name);
  Future<Either<Failure,Unit>> updateEmail(String pass,String email);
  Future<Either<Failure,String>> uploadImage(File image,String? oldUrl);
  Future<Either<Failure,Unit>> updatePassword(String currentPass,String newPass);

}