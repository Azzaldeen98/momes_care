import 'package:dartz/dartz.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/forum/data/models/comment_model.dart';
import 'package:moms_care/features/forum/domain/repository/Comment_repository.dart';
import '../../domain/entities/Comment.dart';
import '../dataSource/remote/comment/comments_remote_data_source.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';





// typedef Future<T> ReadOrAddOrUpdateOrDelete<T>();

class CommentRepositoryImpl implements CommentRepository {

  final CommentRemoteDataSource  remoteDataSource;
  final NetworkInfo  networkInfo;

  CommentRepositoryImpl({required this.remoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<Comment>>> getAllComments() async {

    return await safeExecuteTaskWithNetworkCheck<List<Comment>>(networkInfo,() async{
      return (await  remoteDataSource.getAllComments()).map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addComment(Comment comment) async {
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.addComment(CommentModel.fromEntity(comment));
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

  @override
  Future<Either<Failure, Unit>> updateComment(Comment comment) async {

    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      final response= await  remoteDataSource.updateComment(CommentModel.fromEntity(comment)  );
      return response;
    });
  }

  @override
  Future<Either<Failure, Comment>> getComment(int id) async{
      return await safeExecuteTaskWithNetworkCheck<Comment>(networkInfo,() async{
        final response= await  remoteDataSource.getComment(id);
        return response.toEntity();
      });

  }

  @override
  Future<Either<Failure, bool>> likeUnLikeComment(int commentId) async {
    return await safeExecuteTaskWithNetworkCheck<bool>(networkInfo,() async{
      return  await  remoteDataSource.likeUnLikeComment(commentId);
    });

  }




}