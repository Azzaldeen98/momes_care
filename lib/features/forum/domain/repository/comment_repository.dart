

import 'package:dartz/dartz.dart';

import 'package:moms_care/core/error/faiture.dart';
import '../entities/Comment.dart';


abstract  class CommentRepository {

  Future<Either<Failure,List<Comment>>> getAllComments();
  Future<Either<Failure,Unit>> addComment(Comment comment);
  Future<Either<Failure,bool>> likeUnLikeComment(int commentId);
  Future<Either<Failure,Unit>> updateComment(Comment comment);
  Future<Either<Failure,Unit>> deleteComment(int commentId);
  Future<Either<Failure,Comment>> getComment(int id);

}