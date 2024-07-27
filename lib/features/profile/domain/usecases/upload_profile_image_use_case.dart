 import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../repository/profile_repository.dart';


 class UploadProfileImageUseCase {

   final ProfileRepository _repository;
   UploadProfileImageUseCase(this._repository);

   @override
   Future<Either<Failure,String>> call(File image,String? oldUrl) async {
     return  await _repository.uploadImage(image,oldUrl);
   }

 }
