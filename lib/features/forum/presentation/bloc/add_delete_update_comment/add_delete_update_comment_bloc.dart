


import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/error/message_failure_message.dart';


import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/error/faiture.dart';
import '../../../domain/entities/Comment.dart';
import '../../../domain/usecases/comment/add_comment_use_case.dart';
import '../../../domain/usecases/comment/delete_comment_use_case.dart';
import '../../../domain/usecases/comment/update_comment_use_case.dart';
import 'add_delete_update_comment_event.dart';
import 'add_delete_update_comment_state.dart';



class AddDeleteUpdateCommentBloc extends Bloc<AddDeleteUpdateCommentEvent,AddDeleteUpdateCommentState>{

 final AddNewCommentUseCase  addCommentUseCase;
 final UpdateCommentUseCase  updateCommentUseCase;
 final DeleteCommentUseCase  deleteCommentUseCase;

 AddDeleteUpdateCommentBloc({
    required this.addCommentUseCase,
    required this.updateCommentUseCase,
    required this.deleteCommentUseCase,
  }) :super(AddDeleteUpdateCommentInitial()){

    // on<AddCommentEvent>(_addComment);
    // on<UpdateCommentEvent>(_updateComment);
    // on<DeleteCommentEvent>(_deleteComment);

  }

 // Future<void> _addComment(AddCommentEvent event, Emitter<AddDeleteUpdateCommentState> emit) async{
 //
 //   emit(LoadingAddDeleteUpdateCommentState());
 //
 //   final failureOrsuccess= await addCommentUseCase(event.comment);
 //   _getFailureOrSuccess(failureOrsuccess,ADD_SUCCESS_MESSAGE);
 //
 // }
 // Future<void> _updateComment(UpdateCommentEvent event, Emitter<AddDeleteUpdateCommentState> emit) async{
 //   print("_updateComment@@");
 //   emit(LoadingAddDeleteUpdateCommentState());
 //
 //   final failureOrsuccess= await updateCommentUseCase(event.comment);
 //   _getFailureOrSuccess(failureOrsuccess,UPDATE_SUCCESS_MESSAGE);
 //
 // }
 // Future<void> _deleteComment(DeleteCommentEvent event, Emitter<AddDeleteUpdateCommentState> emit) async{
 //   print("_deleteComment@@");
 //
 //   emit(LoadingAddDeleteUpdateCommentState());
 //   final failureOrsuccess= await deleteCommentUseCase(event.commentId);
 //   _getFailureOrSuccess(failureOrsuccess,DELETE_SUCCESS_MESSAGE);
 //
 // }

 void _getFailureOrSuccess(Either<Failure,Unit> failureOrSuccess,String message ){
   failureOrSuccess.fold(
           (failure){
         Get.back();
         emit(ErrorAddDeleteUpdateCommentState(message: mapFailureToMessage(failure)));
       }, (_){
     emit(AddDeleteUpdateCommentSuccessState(message: message));
   });
 }
}

