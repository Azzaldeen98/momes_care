 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../repository/profile_repository.dart';

 class UpdateUserPasswordUseCase {

   final ProfileRepository _postRepository;
   UpdateUserPasswordUseCase(this._postRepository);

   @override
   Future<Either<Failure,Unit>> call(String currentPass,String newPass) async {
     return  await _postRepository.updatePassword(currentPass,newPass);
   }

 }
