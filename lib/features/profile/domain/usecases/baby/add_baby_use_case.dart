 import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';
import 'package:moms_care/features/profile/domain/repository/profile_babies_repository.dart';

class AddBabyUseCase {

  final BabiesRepository _postRepository;
  AddBabyUseCase(this._postRepository);

  @override
  Future<Either<Failure,Unit>> call(Baby baby) async {
    print("AddBabyUseCase");
    return  await _postRepository.createBaby(baby);
  }

}

