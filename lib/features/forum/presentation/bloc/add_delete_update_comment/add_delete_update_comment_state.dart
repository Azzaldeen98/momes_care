

import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enam/forum_pages.dart';
import '../../../domain/entities/Comment.dart';

abstract class AddDeleteUpdateCommentState extends Equatable {
  const AddDeleteUpdateCommentState();
  @override
  List<Object> get props => [];
}
//!Initial
class AddDeleteUpdateCommentInitial extends AddDeleteUpdateCommentState{
  const AddDeleteUpdateCommentInitial();
}

class LoadingAddDeleteUpdateCommentState extends AddDeleteUpdateCommentState{
  const LoadingAddDeleteUpdateCommentState();
}

class AddDeleteUpdateCommentSuccessState extends AddDeleteUpdateCommentState{
  final String message;
  const AddDeleteUpdateCommentSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}


class ErrorAddDeleteUpdateCommentState extends AddDeleteUpdateCommentState {
  final String message;
  const ErrorAddDeleteUpdateCommentState({required this.message});
  @override
  List<Object> get props => [message];
}

