

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/forum/data/models/post_model.dart';
import 'package:moms_care/features/forum/domain/entities/Comment.dart';

import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/core/error/exception.dart';
import '../../domain/repository/post_repository.dart';
import '../dataSource/remote/post/posts_remote_data_source.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';

import '../models/comment_model.dart';

// typedef Future<T> ReadOrAddOrUpdateOrDelete<T>();

class PostRepositoryImpl  implements PostRepository{

  final PostRemoteDataSource  remoteDataSource;
  final NetworkInfo  networkInfo;

  PostRepositoryImpl({required this.remoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {

    return await safeExecuteTaskWithNetworkCheck<List<Post>>(networkInfo,() async{
      return (await  remoteDataSource.getAllPosts()).map((item)=> item.toEntity()).toList();
    });
  }
  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.addPost(PostModel.fromEntity(post));
      return response;
    });
  }
  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {

    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.deletePost(id);
      return response;
    });
  }
  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {

    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.updatePost(PostModel.fromEntity(post));
      return response;
    });
  }
  @override
  Future<Either<Failure, Post>> getPost(int id) async{
      return await safeExecuteTaskWithNetworkCheck<Post>(networkInfo,() async{
        final response= await  remoteDataSource.getPost(id);
        return response.toEntity();
      });

  }
  @override
  Future<Either<Failure, bool>> likeUnLikePost(int postId) async {
    return await safeExecuteTaskWithNetworkCheck<bool>(networkInfo,() async{
      return  await  remoteDataSource.likeUnLikePost(postId);
    });
    throw UnimplementedError();
  }

  //==============================================================================
  @override
  Future<Either<Failure, Unit>> addComment(Comment comment) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.addComment(CommentModel.fromEntity(comment));
      return response;
    });
  }
  @override
  Future<Either<Failure, bool>> likeUnLikeComment(int commentId) async{
    return await safeExecuteTaskWithNetworkCheck<bool>(networkInfo,() async{
      return  await  remoteDataSource.likeUnLikeComment(commentId);
    });
  }
  @override
  Future<Either<Failure, Unit>> updateComment(Comment comment) async {

    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.updateComment(CommentModel.fromEntity(comment)  );
      return response;
    });
  }
  @override
  Future<Either<Failure, Unit>> deleteComment(int id) async {

    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.deleteComment(id);
      return response;
    });
  }




}