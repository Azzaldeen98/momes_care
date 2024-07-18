

import 'package:equatable/equatable.dart';

import 'package:moms_care/core/constants/enam/forum_pages.dart';
import '../../../domain/entities/Post.dart';

abstract class AddDeleteUpdateState extends Equatable {

  const AddDeleteUpdateState();
  @override
  List<Object> get props => [];
}
//!Initial
class AddDeleteUpdateInitial extends AddDeleteUpdateState{
  const AddDeleteUpdateInitial();
}
class LoadingAddDeleteUpdateState extends AddDeleteUpdateState{
  const LoadingAddDeleteUpdateState();
}

class LikeUnLikeState extends AddDeleteUpdateState{
  final bool userLiked;
  const LikeUnLikeState({required this.userLiked});
}
class AddDeleteUpdateSuccessState extends AddDeleteUpdateState{
  final String message;
  const AddDeleteUpdateSuccessState({required this.message}) ;
  @override
  List<Object> get props => [message];
}
class ErrorAddDeleteUpdateState extends AddDeleteUpdateState {
  final String message;
  const ErrorAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message];
}

//**********************************************************

class AddDeleteUpdatePostState extends AddDeleteUpdateState{
  const AddDeleteUpdatePostState();
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



