 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../repository/profile_repository.dart';

class GetMyPostsUseCase {

  final ProfileRepository _postRepository;
  GetMyPostsUseCase(this._postRepository);

  @override
  Future<Either<Failure,List<Post>>> call() async {
    return  await _postRepository.getMyPosts();
  }

}