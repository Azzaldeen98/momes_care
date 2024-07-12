 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import '../../../../../core/error/faiture.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repository/post_repository.dart';

class LikeUnLikePostUseCase { //implements UseCase<Either<Failure,List<Post>>,void>{

  final PostRepository _postRepository;
  LikeUnLikePostUseCase(this._postRepository);

  @override
  Future<Either<Failure, bool>> call(int postId) async {
    return await _postRepository.likeUnLikePost(postId);
  }


}
