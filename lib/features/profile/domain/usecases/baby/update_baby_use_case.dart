 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';
import 'package:moms_care/features/profile/domain/repository/profile_babies_repository.dart';
import '../../repository/profile_repository.dart';

class UpdateBabyUseCase {

  final BabiesRepository _postRepository;
  UpdateBabyUseCase(this._postRepository);

  @override
  Future<Either<Failure,Unit>> call(Baby model) async {
    return  await _postRepository.updateBaby(model);
  }

}



