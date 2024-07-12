


import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/features/forum/domain/usecases/post/add_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/delete_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/like_unlike_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/update_post_use_case.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_event.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_state.dart';
import 'package:moms_care/features/home/persention/pages/moms_care_view.dart';
// import 'package:nb_utils/nb_utils.dart';

import '../../../../../core/utils/dailog/message/message_box.dart';
import '../../../domain/entities/Post.dart';
import '../../../domain/usecases/post/get_all_posts_use_case.dart';
import '../../pages/post/post_details.dart';

class PostBloc extends Bloc<PostEvent,PostState>{

 final GetAllPostsUseCase  getAllPostsUseCase;
 final AddPostUseCase  addPostUseCase;
 final UpdatePostUseCase  updatePostUseCase;
 final DeletePostUseCase  deletePostUseCase;
 final LikeUnLikePostUseCase likeUnLikePostUseCase;


  PostBloc({
    required this.getAllPostsUseCase,
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
    required this.likeUnLikePostUseCase,
  }) :super(PostsInitial()){


    on<GetAllPostsEvent>(_getAllPosts);
    on<AddPostEvent>(_addPost);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);
    on<DetailsPostEvent>(_detailsPost);
    on<GoToPagePostEvent>(_goToPagePost);
    on<LikeUnLikePostEvent>(_likeUnLikePost);
  }

 Future<void> _getAllPosts(GetAllPostsEvent event, Emitter<PostState> emit) async{
    emit(LoadingPostsState());

     final failureOrPosts=await getAllPostsUseCase();

    failureOrPosts.fold(
        (failure){
          emit(ErrorPostsState(message: mapFailureToMessage(failure)));
          // Get.back();
          // emit(const GoToPageState(pageAuth: PageAuth.REGISTER_PAGE));
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
 Future<void> _addPost(AddPostEvent event, Emitter<PostState> emit) async{

   emit(LoadingPostsState());

   final failureOrsuccess= await addPostUseCase(Post(title:event.title,body:event.content));
   failureOrsuccess.fold(
         (failure){
           Get.back();
           emit(ErrorPostsState(message: mapFailureToMessage(failure)));
         },
         (_){
               print("AddPostSuccessState is @@!!!");
             emit(AddPostSuccessState());
         });
 }
 Future<void> _updatePost(UpdatePostEvent event, Emitter<PostState> emit) async{
   print("_updatePost@@");

   emit(LoadingPostsState());
   final failureOrsuccess= await updatePostUseCase(event.post);
   failureOrsuccess.fold(
       (failure){
         Get.back();
         emit(ErrorPostsState(message: mapFailureToMessage(failure)));
       },
       (_){
         emit(UpdatedPostSuccessState());
       });
 }
 Future<void> _deletePost(DeletePostEvent event, Emitter<PostState> emit) async{
   print("_deletePost@@");

   emit(LoadingPostsState());
   final failureOrsuccess= await deletePostUseCase(event.postId);
   failureOrsuccess.fold(
       (failure){
         Get.back();
         emit(ErrorPostsState(message: mapFailureToMessage(failure)));
       },
       (_){
         emit(DeletedPostSuccessState());
       });
 }
 Future<void> _goToPagePost(GoToPagePostEvent event, Emitter<PostState> emit) async{}
 Future<void>  _detailsPost(DetailsPostEvent event, Emitter<PostState> emit) async{

   emit(LoadingDetailsPostsState());
   // emit(LoadedDetailsPostState(post: event.post));
   Get.to(PostsDetails(post: event.post,));

 }


}

