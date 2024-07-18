

import 'package:equatable/equatable.dart';

import 'package:moms_care/core/constants/enam/forum_pages.dart';
import '../../../domain/entities/Comment.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  @override
  List<Object> get props => [];
}
//!Initial
class CommentsInitial extends CommentState{
  const CommentsInitial();
}

class LoadingCommentsState extends CommentState{
  const LoadingCommentsState();
}

class LoadingLikeUnLikeCommentState extends CommentState{
  const LoadingLikeUnLikeCommentState();
}

class LoadingDetailsCommentsState extends CommentState{
  const LoadingDetailsCommentsState();

}

class LikeUnLikeCommentSuccessState extends CommentState{
  final bool userLiked;
  const LikeUnLikeCommentSuccessState({required this.userLiked});
}

class LoadedCommentsState extends CommentState{
  final List<Comment> comments;
  const LoadedCommentsState({required this.comments});
  @override
  List<Object> get props => [comments];
}
class LoadedDetailsCommentState extends CommentState{
  final Comment comment;
  const LoadedDetailsCommentState({required this.comment});
  @override
  List<Object> get props => [comment];
}

class ErrorCommentsState extends CommentState {
  final String message;
  const ErrorCommentsState({required this.message});
  @override
  List<Object> get props => [message];
}

