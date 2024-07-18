 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import '../../repository/post_repository.dart';

class DeletePostUseCase {

  final PostRepository _postRepository;
  DeletePostUseCase(this._postRepository);

  @override
  Future<Either<Failure,Unit>> call(int postId) async {

    return await _postRepository.deletePost(postId);
  }


}



