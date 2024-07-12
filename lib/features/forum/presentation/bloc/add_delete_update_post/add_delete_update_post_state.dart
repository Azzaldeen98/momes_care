

import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enam/forum_pages.dart';
import '../../../domain/entities/Post.dart';

abstract class AddDeleteUpdatePostState extends Equatable {
  // final List<Post> ? posts;
  // final Post ? post;
  const AddDeleteUpdatePostState();
  @override
  List<Object> get props => [];
}
//!Initial
class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState{
  const AddDeleteUpdatePostInitial();
}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState{
  const LoadingAddDeleteUpdatePostState();
}

class AddDeleteUpdatePostSuccessState extends AddDeleteUpdatePostState{
  final String message;
  const AddDeleteUpdatePostSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}


class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;
  const ErrorAddDeleteUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}

