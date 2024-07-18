 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import '../../repository/comment_repository.dart';
import '../../repository/post_repository.dart';

class DeleteCommentUseCase {

  final PostRepository _commentRepository;
  DeleteCommentUseCase(this._commentRepository);

  @override
  Future<Either<Failure,Unit>> call(int commentId) async {
    print("DeleteCommentUseCase888");
    return await _commentRepository.deleteComment(commentId);
  }


}
