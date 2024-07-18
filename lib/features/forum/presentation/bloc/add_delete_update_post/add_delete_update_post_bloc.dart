
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/features/forum/domain/usecases/Comment/delete_Comment_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/Comment/update_Comment_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/add_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/delete_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/update_post_use_case.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../../../domain/usecases/Comment/like_unlike_Comment_use_case.dart';
import 'add_delete_update_post_event.dart';
import 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent,AddDeleteUpdateState>{

 final AddPostUseCase  addPostUseCase;
 final UpdatePostUseCase  updatePostUseCase;
 final DeletePostUseCase  deletePostUseCase;

 final AddPostCommentUseCase  addCommentUseCase;
 final UpdateCommentUseCase  updateCommentUseCase;
 final DeleteCommentUseCase   deleteCommentUseCase;


 AddDeleteUpdatePostBloc({
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
   required this.addCommentUseCase,
   required this.updateCommentUseCase,
   required this.deleteCommentUseCase,

  }) :super(AddDeleteUpdateInitial()){

    on<AddPostEvent>(_addPost);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);

    on<AddCommentEvent>(_addComment);
    on<UpdateCommentEvent>(_updateComment);
    on<DeleteCommentEvent>(_deleteComment);


  }

 Future<void> _addPost(AddPostEvent event, Emitter<AddDeleteUpdateState> emit) async{

   emit(LoadingAddDeleteUpdateState());

   final failureOrsuccess= await addPostUseCase(event.post);
   _getFailureOrSuccess(failureOrsuccess,ADD_SUCCESS_MESSAGE);

 }
 Future<void> _updatePost(UpdatePostEvent event, Emitter<AddDeleteUpdateState> emit) async{
   print("_updatePost@@");
   emit(LoadingAddDeleteUpdateState());

   final failureOrsuccess= await updatePostUseCase(event.post);
   _getFailureOrSuccess(failureOrsuccess,UPDATE_SUCCESS_MESSAGE);

 }
 Future<void> _deletePost(DeletePostEvent event, Emitter<AddDeleteUpdateState> emit) async{
   print("_deletePost@@");

   emit(LoadingAddDeleteUpdateState());
   final failureOrsuccess= await deletePostUseCase(event.postId);
   _getFailureOrSuccess(failureOrsuccess,DELETE_SUCCESS_MESSAGE);

 }

 Future<void> _addComment(AddCommentEvent event, Emitter<AddDeleteUpdateState> emit) async{
   print("_addPostComment@@");
   emit(LoadingAddDeleteUpdateState());

   final failureOrsuccess= await addCommentUseCase(event.comment);
   _getFailureOrSuccess(failureOrsuccess,ADD_SUCCESS_MESSAGE);

 }
 Future<void> _updateComment(UpdateCommentEvent event, Emitter<AddDeleteUpdateState> emit) async{
   print("_updateComment@@");
   emit(LoadingAddDeleteUpdateState());

   final failureOrsuccess= await updateCommentUseCase(event.comment);
   _getFailureOrSuccess(failureOrsuccess,UPDATE_SUCCESS_MESSAGE);

 }
 Future<void> _deleteComment(DeleteCommentEvent event, Emitter<AddDeleteUpdateState> emit) async{
   print("_deleteComment@@");

   emit(LoadingAddDeleteUpdateState());
   final failureOrsuccess= await deleteCommentUseCase(event.commentId);
   _getFailureOrSuccess(failureOrsuccess,DELETE_SUCCESS_MESSAGE);

 }

 void _getFailureOrSuccess(Either<Failure,Unit> failureOrSuccess,String message ){
   failureOrSuccess.fold(
           (failure){
         Get.back();
         emit(ErrorAddDeleteUpdateState(message: mapFailureToMessage(failure)));
       }, (_){
     emit(AddDeleteUpdateSuccessState(message: message));
   });
 }


}

