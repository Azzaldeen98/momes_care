 import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../../entities/Comment.dart';
import '../../repository/post_repository.dart';


class AddNewCommentUseCase {

  final PostRepository _commentRepository;
  AddNewCommentUseCase(this._commentRepository);

  @override
  Future<Either<Failure,Unit>> call(Comment comment) async {
    return await _commentRepository.addComment(comment);
  }


}
