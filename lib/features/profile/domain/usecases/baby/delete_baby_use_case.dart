 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';
import 'package:moms_care/features/profile/domain/repository/profile_babies_repository.dart';
import '../../repository/profile_repository.dart';

class DeleteBabyUseCase {

  final BabiesRepository _postRepository;
  DeleteBabyUseCase(this._postRepository);

  @override
  Future<Either<Failure,Unit>> call(int id) async {
    return  await _postRepository.deleteBaby(id);
  }

}


