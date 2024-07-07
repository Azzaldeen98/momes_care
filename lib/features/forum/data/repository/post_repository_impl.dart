

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/forum/data/models/post_model.dart';

import 'package:moms_care/features/forum/domain/entities/Post.dart';

import '../../../../core/error/exception.dart';
import '../../domain/repository/post_repository.dart';
import '../dataSource/remote/posts_remote_data_source.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';

// typedef Future<T> ReadOrAddOrUpdateOrDelete<T>();

class PostRepositoryImpl  implements PostRepository{

  final PostRemoteDataSource  remoteDataSource;
  final NetworkInfo  networkInfo;

  PostRepositoryImpl({required this.remoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {

    return await safeExecuteTaskWithNetworkCheck<List<Post>>(networkInfo,() async{
      final response= await  remoteDataSource.getAllPosts();
      return response;
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
  Future<Either<Failure, Unit>> deletePost(int postId) async {

    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.deletePost(postId);
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


}