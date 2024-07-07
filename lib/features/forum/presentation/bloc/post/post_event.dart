


import 'package:equatable/equatable.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import '../../../../../core/constants/enam/forum_pages.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => [];
}

 class GetAllPostsEvent extends PostEvent{}

class RefreshPostsEvent extends PostEvent{}

 class AddPostEvent extends PostEvent{
   const AddPostEvent({required this.post});
   final Post post;
 }
 class UpdatePostEvent extends PostEvent{
   const UpdatePostEvent({required this.post});
   final Post post;
 }
 class DeletePostEvent extends PostEvent{
   const DeletePostEvent({required this.postId});
   final int postId;
 }

class GoToPagePostEvent extends PostEvent {
  const GoToPagePostEvent({required this.pagePost});
  final PagePost pagePost;
}