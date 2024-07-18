 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import '../../repository/post_repository.dart';

class GetAllPostsUseCase { //implements UseCase<Either<Failure,List<Post>>,void>{

  final PostRepository _postRepository;
  GetAllPostsUseCase(this._postRepository);

  @override
  Future<Either<Failure,List<Post>>> call() async {
    return  await _postRepository.getAllPosts();
  }


}