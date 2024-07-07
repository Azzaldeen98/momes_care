

import 'package:dartz/dartz.dart';

import '../../../../core/error/faiture.dart';
import '../entities/Post.dart';


abstract  class PostRepository {

  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure,Unit>> addPost(Post post);
  Future<Either<Failure,Unit>> updatePost(Post post);
  Future<Either<Failure,Unit>> deletePost(int postId);
  
}