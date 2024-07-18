 import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import '../../repository/post_repository.dart';
class DetailsPostUseCase {

  DetailsPostUseCase();

  @override
  Post call(Post post)  {
    return  post;
  }
}