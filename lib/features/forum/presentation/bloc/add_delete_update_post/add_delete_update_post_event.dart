


import 'package:equatable/equatable.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/constants/enam/forum_pages.dart';
import '../../../domain/entities/Comment.dart';

abstract class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();
  @override
  List<Object> get props => [];
}


 class AddPostEvent extends AddDeleteUpdatePostEvent{
   const AddPostEvent( {required this.post});
   final Post post;
   @override
   List<Object> get props => [post];
 }
 class UpdatePostEvent extends AddDeleteUpdatePostEvent{
   const UpdatePostEvent({required this.post});
   final Post post;
   @override
   List<Object> get props => [post];
 }
 class DeletePostEvent extends AddDeleteUpdatePostEvent{
   const DeletePostEvent({required this.postId});
   final int postId;
   @override
   List<Object> get props => [postId];
 }


class AddCommentEvent extends AddDeleteUpdatePostEvent{
  const AddCommentEvent( {required this.comment});
  final Comment comment;
  @override
  List<Object> get props => [comment];
}
class UpdateCommentEvent extends AddDeleteUpdatePostEvent{
  const UpdateCommentEvent({required this.comment});
  final Comment comment;
  @override
  List<Object> get props => [comment];
}
class DeleteCommentEvent extends AddDeleteUpdatePostEvent{
  const DeleteCommentEvent({required this.commentId});
  final int commentId;
  @override
  List<Object> get props => [commentId];
}


