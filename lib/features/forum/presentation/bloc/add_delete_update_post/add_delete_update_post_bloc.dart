
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/features/forum/domain/usecases/post/add_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/delete_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/update_post_use_case.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/error/faiture.dart';
import 'add_delete_update_post_event.dart';
import 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent,AddDeleteUpdatePostState>{

 final AddPostUseCase  addPostUseCase;
 final UpdatePostUseCase  updatePostUseCase;
 final DeletePostUseCase  deletePostUseCase;

 AddDeleteUpdatePostBloc({
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) :super(AddDeleteUpdatePostInitial()){
    on<AddPostEvent>(_addPost);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);

  }

 Future<void> _addPost(AddPostEvent event, Emitter<AddDeleteUpdatePostState> emit) async{

   emit(LoadingAddDeleteUpdatePostState());

   final failureOrsuccess= await addPostUseCase(event.post);
   _getFailureOrSuccess(failureOrsuccess,ADD_SUCCESS_MESSAGE);

 }
 Future<void> _updatePost(UpdatePostEvent event, Emitter<AddDeleteUpdatePostState> emit) async{
   print("_updatePost@@");
   emit(LoadingAddDeleteUpdatePostState());

   final failureOrsuccess= await updatePostUseCase(event.post);
   _getFailureOrSuccess(failureOrsuccess,UPDATE_SUCCESS_MESSAGE);

 }
 Future<void> _deletePost(DeletePostEvent event, Emitter<AddDeleteUpdatePostState> emit) async{
   print("_deletePost@@");

   emit(LoadingAddDeleteUpdatePostState());
   final failureOrsuccess= await deletePostUseCase(event.postId);
   _getFailureOrSuccess(failureOrsuccess,DELETE_SUCCESS_MESSAGE);

 }

 void _getFailureOrSuccess(Either<Failure,Unit> failureOrSuccess,String message ){
   failureOrSuccess.fold(
           (failure){
         Get.back();
         emit(ErrorAddDeleteUpdatePostState(message: mapFailureToMessage(failure)));
       }, (_){
     emit(AddDeleteUpdatePostSuccessState(message: message));
   });
 }
}

