 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import '../../entities/Comment.dart';
import '../../repository/Comment_repository.dart';
import '../../repository/post_repository.dart';

class AddPostUseCase { //implements UseCase<Either<Failure,List<Post>>,void>{

  final PostRepository _postRepository;
  AddPostUseCase(this._postRepository);

  @override
  Future<Either<Failure,Unit>> call(Post _post) async {
    return await _postRepository.addPost(_post);
  }


}

 class AddPostCommentUseCase { //implements UseCase<Either<Failure,List<Post>>,void>{

   final PostRepository _commentRepository;
   AddPostCommentUseCase(this._commentRepository);

   @override
   Future<Either<Failure,Unit>> call(Comment _comment) async {
     print("AddPostCommentUseCase@@");
     return await _commentRepository.addComment(_comment);
   }


 }
