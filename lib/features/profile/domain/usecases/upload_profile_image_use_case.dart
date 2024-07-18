 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../repository/profile_repository.dart';


 class UploadProfileImageUseCase {

   final ProfileRepository _postRepository;
   UploadProfileImageUseCase(this._postRepository);

   @override
   Future<Either<Failure,Unit>> call(String email) async {
     return  await _postRepository.updateEmail(email);
   }

 }
