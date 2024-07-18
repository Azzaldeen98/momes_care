


import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/features/forum/domain/usecases/Comment/like_unlike_Comment_use_case.dart';

import '../../../domain/usecases/Comment/get_all_Comments_use_case.dart';
import 'Comment_event.dart';
import 'Comment_state.dart';



class CommentBloc extends Bloc<CommentEvent,CommentState>{

 final GetAllCommentsUseCase  getAllCommentsUseCase;
 final LikeUnLikeCommentUseCase likeUnLikeCommentUseCase;


  CommentBloc({
    required this.getAllCommentsUseCase,
    required this.likeUnLikeCommentUseCase,

  }) :super(CommentsInitial()){
    on<GetAllCommentsEvent>(_getAllComments);
    on<LikeUnLikeCommentEvent>(_likeUnLikeComment);
    on<RefreshCommentsEvent>((e,r){});
    on<DetailsCommentEvent>((e,r){});
  }

 Future<void> _getAllComments(GetAllCommentsEvent event, Emitter<CommentState> emit) async{
    emit(LoadingCommentsState());

     final failureOrComments=await getAllCommentsUseCase();

    failureOrComments.fold(
        (failure){
          emit(ErrorCommentsState(message: mapFailureToMessage(failure)));
          // Get.back();
          // emit(const GoToPageState(pageAuth: PageAuth.REGISTER_PAGE));
        },
        (_Comments){
            emit(LoadedCommentsState(comments: _Comments));
        });


 }
 FutureOr<void> _likeUnLikeComment(LikeUnLikeCommentEvent event, Emitter<CommentState> emit) async {

   emit(LoadingLikeUnLikeCommentState());

   final failureOrsuccess=await likeUnLikeCommentUseCase(event!.commentId);

   failureOrsuccess.fold(
           (failure){
         emit(ErrorCommentsState(message: mapFailureToMessage(failure)));
       },
           (_userLiked){
         emit(LikeUnLikeCommentSuccessState( userLiked: _userLiked!));
       });



 }





}

