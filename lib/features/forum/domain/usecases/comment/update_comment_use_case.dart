 import 'package:dartz/dartz.dart';


import 'package:moms_care/core/error/faiture.dart';
import '../../entities/Comment.dart';
import '../../repository/Comment_repository.dart';
import '../../repository/post_repository.dart';


class UpdateCommentUseCase { //implements UseCase<Either<Failure,List<Post>>,void>{

  final PostRepository _commentRepository;
  UpdateCommentUseCase(this._commentRepository);

  @override
  Future<Either<Failure,Unit>> call(Comment _comment) async {

    print("UpdateCommentUseCase ${_comment.contant}");
    return await _commentRepository.updateComment(_comment);
  }


}