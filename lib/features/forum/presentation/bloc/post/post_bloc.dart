


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/features/forum/domain/usecases/post/add_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/delete_post_use_case.dart';
import 'package:moms_care/features/forum/domain/usecases/post/update_post_use_case.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_event.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_state.dart';

import '../../../domain/entities/Post.dart';
import '../../../domain/usecases/post/get_all_posts_use_case.dart';

class PostBloc extends Bloc<PostEvent,PostState>{

 final GetAllPostsUseCase  getAllPostsUseCase;
 final AddPostUseCase  addPostUseCase;
 final UpdatePostUseCase  updatePostUseCase;
 final DeletePostUseCase  deletePostUseCase;

  PostBloc({
    required this.getAllPostsUseCase,
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase
  }) :super(PostsInitial()){

    // on<RefreshPostsEvent>(_refreshPosts);
    on<GetAllPostsEvent>(_getAllPosts);
    on<AddPostEvent>(_addPost);
    on<UpdatePostEvent>(_updatePost);
    on<DeletePostEvent>(_deletePost);
    on<GoToPagePostEvent>(_goToPagePost);
  }
 Future<void> _refreshPosts(RefreshPostsEvent event, Emitter<PostState> emit) async{

   emit(LoadingPostsState());

   final failureOrPosts=await getAllPostsUseCase();
   failureOrPosts.fold(
           (failure){
         emit(ErrorPostsState(message: mapFailureToMessage(failure)));
       },
           (_posts){
         emit(LoadedPostsState(posts: _posts));
       });

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
 Future<void> _addPost(AddPostEvent event, Emitter<PostState> emit) async{}
 Future<void> _updatePost(UpdatePostEvent event, Emitter<PostState> emit) async{}
 Future<void> _deletePost(DeletePostEvent event, Emitter<PostState> emit) async{}
 Future<void> _goToPagePost(GoToPagePostEvent event, Emitter<PostState> emit) async{}

}