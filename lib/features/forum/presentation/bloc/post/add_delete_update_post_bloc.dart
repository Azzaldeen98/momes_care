


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

import '../../../domain/entities/Post.dart';
import '../../../domain/usecases/post/get_all_posts_use_case.dart';
import '../../pages/post/post_details.dart';

class AddDeleteUpdatePostBloc extends Bloc<PostEvent,PostState>{

 final AddPostUseCase  addPostUseCase;
 final UpdatePostUseCase  updatePostUseCase;
 final DeletePostUseCase  deletePostUseCase;

 AddDeleteUpdatePostBloc({
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) :super(PostsInitial()){
    on<AddPostEvent>(_addPost);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);
    on<GoToPagePostEvent>(_goToPagePost);
  }



 Future<void> _addPost(AddPostEvent event, Emitter<PostState> emit) async{

   emit(LoadingPostsState());

   final failureOrsuccess=await addPostUseCase(Post(title:event.title,body:event.content));

   failureOrsuccess.fold(
           (failure){
         emit(ErrorPostsState(message: mapFailureToMessage(failure)));
       },
       (_){
           emit(AddPostSuccessState());
       });
 }
 Future<void> _updatePost(UpdatePostEvent event, Emitter<PostState> emit) async{}
 Future<void> _deletePost(DeletePostEvent event, Emitter<PostState> emit) async{}
 Future<void> _goToPagePost(GoToPagePostEvent event, Emitter<PostState> emit) async{}

}

