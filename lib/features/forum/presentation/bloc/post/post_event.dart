


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

class DetailsPostEvent extends PostEvent{
  const DetailsPostEvent({required this.post});
  final Post post;
}

class LikeUnLikePostEvent extends PostEvent{
  const LikeUnLikePostEvent({required this.postId});
  final int postId;
}

 class AddPostEvent extends PostEvent{
   const AddPostEvent( {required this.title,required this.content});
   final String title;
   final String content;
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