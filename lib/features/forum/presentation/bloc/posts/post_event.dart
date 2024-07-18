


import 'package:equatable/equatable.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/constants/enam/forum_pages.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => [];
}

 class GetAllPostsEvent extends PostEvent{}

class RefreshPostsEvent extends PostEvent{}

class DetailsPostEvent extends PostEvent{
  const DetailsPostEvent({required this.post});
  final Post post;
}

class GetPostEvent extends PostEvent{
  const GetPostEvent({required this.postId});
  final int postId;
}


class LikeUnLikePostEvent extends PostEvent{
  const LikeUnLikePostEvent({required this.postId});
  final int postId;
}

class LikeUnLikeCommentEvent extends PostEvent{
  const LikeUnLikeCommentEvent({required this.commentId});
  final int commentId;
  @override
  List<Object> get props => [commentId];
}

class GoToPagePostEvent extends PostEvent {
  const GoToPagePostEvent({required this.pagePost});
  final PagePost pagePost;
}