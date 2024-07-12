


import 'package:equatable/equatable.dart';
import 'package:moms_care/features/forum/domain/entities/Comment.dart';

import '../../../../../core/constants/enam/forum_pages.dart';
import '../../../domain/entities/Comment.dart';

abstract class AddDeleteUpdateCommentEvent extends Equatable {
  const AddDeleteUpdateCommentEvent();
  @override
  List<Object> get props => [];
}


 class AddCommentEvent extends AddDeleteUpdateCommentEvent{
   const AddCommentEvent( {required this.comment});
   final Comment comment;
   @override
   List<Object> get props => [comment];
 }
 class UpdateCommentEvent extends AddDeleteUpdateCommentEvent{
   const UpdateCommentEvent({required this.comment});
   final Comment comment;
   @override
   List<Object> get props => [comment];
 }
 class DeleteCommentEvent extends AddDeleteUpdateCommentEvent{
   const DeleteCommentEvent({required this.commentId});
   final int commentId;
   @override
   List<Object> get props => [commentId];
 }

