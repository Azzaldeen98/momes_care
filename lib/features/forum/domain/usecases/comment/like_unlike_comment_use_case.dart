 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import '../../repository/Comment_repository.dart';
import '../../repository/post_repository.dart';

class LikeUnLikeCommentUseCase {

  final PostRepository _commentRepository;
  LikeUnLikeCommentUseCase(this._commentRepository);

  @override
  Future<Either<Failure, bool>> call(int commentId) async {
    return await _commentRepository.likeUnLikeComment(commentId);
  }


}
