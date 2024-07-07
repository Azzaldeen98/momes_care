

import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enam/forum_pages.dart';
import '../../../domain/entities/Post.dart';

abstract class PostState extends Equatable {
  // final List<Post> ? posts;
  // final Post ? post;
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

class LoadedPostsState extends PostState{
  final List<Post> posts;
  const LoadedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostState {
  final String message;
  const ErrorPostsState({required this.message});
  @override
  List<Object> get props => [message];
}

class GoToPostPageState extends PostState {
  const GoToPostPageState({required this.pagePost});
  final PagePost pagePost;

  @override
  List<Object> get props => [pagePost];
}