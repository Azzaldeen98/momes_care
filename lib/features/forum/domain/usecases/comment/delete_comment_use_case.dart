 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import '../../../../../core/error/faiture.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repository/comment_repository.dart';
import '../../repository/post_repository.dart';

class DeleteCommentUseCase {

  final CommentRepository _commentRepository;
  DeleteCommentUseCase(this._commentRepository);

  @override
  Future<Either<Failure,Unit>> call(int commentId) async {

    return await _commentRepository.deleteComment(commentId);
  }


}
