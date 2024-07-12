 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Comment.dart';

import '../../../../../core/error/faiture.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repository/Comment_repository.dart';

class GetAllCommentsUseCase {

  final CommentRepository _commentRepository;
  GetAllCommentsUseCase(this._commentRepository);

  @override
  Future<Either<Failure,List<Comment>>> call() async {
    return  await _commentRepository.getAllComments();
  }


}