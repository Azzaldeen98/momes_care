 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../repository/profile_repository.dart';

class RefreshProfileInfoUseCase {

  final ProfileRepository _postRepository;
  RefreshProfileInfoUseCase(this._postRepository);

  @override
  Future<Either<Failure,Profile>> call() async {
    return  await _postRepository.refreshProfileInfo();
  }

}