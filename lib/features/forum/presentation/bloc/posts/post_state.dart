

import 'package:equatable/equatable.dart';

import 'package:moms_care/core/constants/enam/forum_pages.dart';
import '../../../domain/entities/Post.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}
//!Initial
class PostsInitial extends PostState{
  const PostsInitial();
}

class LoadingPostsState extends PostState{
  const LoadingPostsState();
}
class LoadingPostsCommentsState extends PostState{
  const LoadingPostsCommentsState();
}

class LoadingLikeUnLikePostState extends PostState{
  const LoadingLikeUnLikePostState();
}

class LoadingLikeUnLikeState extends PostState{
  const LoadingLikeUnLikeState();
}

class LoadingDetailsPostsState extends PostState{
  const LoadingDetailsPostsState();

}
class LoadingAddPostState extends PostState{
  const LoadingAddPostState();
}

class AddPostSuccessState extends PostState{
  const AddPostSuccessState();
}

// class DeletedPostSuccessState extends PostState{
//   const DeletedPostSuccessState();
// }
// class UpdatedPostSuccessState extends PostState{
//   const UpdatedPostSuccessState();
// }

class LikeUnLikeSuccessState  extends PostState{
  final bool userLiked;
  const LikeUnLikeSuccessState({required this.userLiked});
}


class LikeUnLikePostSuccessState extends LikeUnLikeSuccessState{
  LikeUnLikePostSuccessState({required super.userLiked});
}




class LoadedPostsState extends PostState{
  final List<Post> posts;
  const LoadedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}
class LoadedDetailsPostState extends PostState{
  final Post post;
  const LoadedDetailsPostState({required this.post});
  @override
  List<Object> get props => [post];
}


class ErrorPostsState extends PostState {
  final String message;
  const ErrorPostsState({required this.message});
  @override
  List<Object> get props => [message];
}


class ErrorPostCommentState extends ErrorPostsState {
  ErrorPostCommentState({required super.message});
}



class GoToPostPageState extends PostState {
  const GoToPostPageState({required this.pagePost});
  final PagePost pagePost;

  @override
  List<Object> get props => [pagePost];
}