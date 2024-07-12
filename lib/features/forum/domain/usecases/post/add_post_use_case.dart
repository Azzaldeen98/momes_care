 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import '../../../../../core/error/faiture.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repository/post_repository.dart';

class AddPostUseCase { //implements UseCase<Either<Failure,List<Post>>,void>{

  final PostRepository _postRepository;
  AddPostUseCase(this._postRepository);

  @override
  Future<Either<Failure,Unit>> call(Post _post) async {
    return await _postRepository.addPost(_post);
  }


}
