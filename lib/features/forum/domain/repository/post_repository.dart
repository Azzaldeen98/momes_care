

import 'package:dartz/dartz.dart';

import 'package:moms_care/core/error/faiture.dart';
import '../entities/Comment.dart';
import '../entities/Post.dart';


abstract  class PostRepository {

  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure,List<Post>>> getRefreshPosts();
  Future<Either<Failure,Unit>> addPost(Post post);
  Future<Either<Failure,bool>> likeUnLikePost(int postId);
  Future<Either<Failure,Unit>> updatePost(Post post);
  Future<Either<Failure,Unit>> deletePost(int postId);
  Future<Either<Failure,Post>> getPost(int id);

  Future<Either<Failure,Unit>> addComment(Comment comment);
  Future<Either<Failure,bool>> likeUnLikeComment(int commentId);
  Future<Either<Failure,Unit>> updateComment(Comment comment);
  Future<Either<Failure,Unit>> deleteComment(int commentId);

}