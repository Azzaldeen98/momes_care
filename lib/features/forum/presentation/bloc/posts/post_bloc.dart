


import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/features/forum/domain/usecases/post/add_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/delete_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/like_unlike_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/update_post_use_case.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_state.dart';
import 'package:moms_care/features/forum/presentation/pages/comment/comments_page.dart';
import 'package:moms_care/features/home/persention/pages/moms_care_view.dart';
// import 'package:nb_utils/nb_utils.dart';

import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import '../../../domain/entities/Post.dart';
import '../../../domain/usecases/Comment/like_unlike_Comment_use_case.dart';
import '../../../domain/usecases/post/get_all_posts_use_case.dart';
import '../../../domain/usecases/post/get_post_use_case.dart';
import '../../pages/post/post_details.dart';

class PostBloc extends Bloc<PostEvent,PostState>{

 final GetAllPostsUseCase  getAllPostsUseCase;
 final LikeUnLikePostUseCase likeUnLikePostUseCase;
 final LikeUnLikeCommentUseCase   likeUnLikeCommentUseCase;
 final GetPostUseCase getPostUseCase;

  PostBloc({
    required this.getAllPostsUseCase,
    required this.likeUnLikePostUseCase,
    required this.getPostUseCase,
    required this.likeUnLikeCommentUseCase,
  }) :super(PostsInitial()){

    on<GetAllPostsEvent>(_getAllPosts);
    on<DetailsPostEvent>(_detailsPost);
    on<GetPostEvent>(_getPost);
    on<LikeUnLikePostEvent>(_likeUnLikePost);
    on<LikeUnLikeCommentEvent>(_likeUnLikeComment);


  }
 FutureOr<void> _getPost(GetPostEvent event, Emitter<PostState> emit) async {
   emit(const LoadingDetailsPostState());
   final failureOrPosts=await getPostUseCase(event.postId);
   failureOrPosts.fold(
           (failure){
         emit(ErrorPostCommentState(message: mapFailureToMessage(failure)));
       },
       (_post){
         emit(LoadedDetailsPostState(post:_post));
       });
 }
 Future<void> _getAllPosts(GetAllPostsEvent event, Emitter<PostState> emit) async{
    emit(const LoadingPostsState());
     final failureOrPosts=await getAllPostsUseCase();
    failureOrPosts.fold(
        (failure){
          emit(ErrorPostsState(message: mapFailureToMessage(failure)));
          // Get.back();
        },
        (_posts){
            emit(LoadedPostsState(posts: _posts));
        });


 }
 FutureOr<void> _likeUnLikePost(LikeUnLikePostEvent event, Emitter<PostState> emit) async {

   emit(LoadingLikeUnLikePostState());

   final failureOrsuccess=await likeUnLikePostUseCase(event!.postId);
   failureOrsuccess.fold(
           (failure){
         emit(ErrorPostsState(message: mapFailureToMessage(failure)));
       },
           (_userLiked){
         emit(LikeUnLikePostSuccessState( userLiked: _userLiked!));
       });



 }

 Future<void>  _detailsPost(DetailsPostEvent event, Emitter<PostState> emit) async{

   emit(const LoadingDetailsPostState());
   // emit(LoadedDetailsPostState(post: event.post));
   Get.off(CommentsPage(post: event.post,));

 }
 FutureOr<void> _likeUnLikeComment(LikeUnLikeCommentEvent event, Emitter<PostState> emit)async {

    emit(const LoadingLikeUnLikeState());
   final failureOrsuccess= await likeUnLikeCommentUseCase(event.commentId);
   failureOrsuccess.fold(
           (failure){
         emit(ErrorPostCommentState(message: mapFailureToMessage(failure)));
       }, (_userLiked){
         emit(LikeUnLikeSuccessState(userLiked: _userLiked!));
       });
 }

 Future<void> _goToPagePost(GoToPagePostEvent event, Emitter<PostState> emit) async{}



}

