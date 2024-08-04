 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../repository/profile_repository.dart';

 class GetAuthorInfoUseCase {

   final ProfileRepository _postRepository;
   GetAuthorInfoUseCase(this._postRepository);

   @override
   Future<Either<Failure,Profile>> call(String userId) async {
     return  await _postRepository.getAuthorInfo(userId);
   }

 }