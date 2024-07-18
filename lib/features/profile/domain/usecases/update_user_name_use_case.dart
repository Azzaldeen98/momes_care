 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../repository/profile_repository.dart';

class UpdateUserNameUseCase {

  final ProfileRepository _postRepository;
  UpdateUserNameUseCase(this._postRepository);

  @override
  Future<Either<Failure,Unit>> call(String name) async {
    return  await _postRepository.updateName(name);
  }

}

