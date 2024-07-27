


import 'package:equatable/equatable.dart';
import '../../../domain/entities/Comment.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
  @override
  List<Object> get props => [];
}

class GetAllCommentsEvent extends CommentEvent{

  const GetAllCommentsEvent({required this.postId});
  final int postId;
  @override
  List<Object> get props => [postId];

}

class RefreshCommentsEvent extends CommentEvent{}

class DetailsCommentEvent extends CommentEvent{
  const DetailsCommentEvent({required this.comment});
  final Comment comment;
  @override
  List<Object> get props => [comment];
}

class LikeUnLikeCommentEvent extends CommentEvent{
  const LikeUnLikeCommentEvent({required this.commentId});
  final int commentId;

  @override
  List<Object> get props => [commentId];
}

 
