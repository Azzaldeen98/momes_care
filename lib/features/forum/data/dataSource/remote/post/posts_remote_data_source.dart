
// part '';

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:moms_care/features/forum/data/models/post_model.dart';
import 'package:retrofit/http.dart';

import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
import '../../../../domain/entities/Post.dart';
import '../../../models/comment_model.dart';

part 'posts_remote_data_source_impl.dart';

@RestApi(baseUrl:"${BASE_URL}/api/v1/Post")
abstract class PostRemoteDataSource{

  factory PostRemoteDataSource() = PostRemoteDataSourceImpl;

  @GET('/getAll')
  Future<List<PostModel>> getAllPosts();

  @GET('/getPost')
  Future<PostModel> getPost(@Query("id") int ? id);




  @POST('/create')
  Future<Unit> addPost(@Body() PostModel model);

  @POST('/likeUnlike')
  Future<bool> likeUnLikePost(@Query("id") int ? id);

  @PUT('/update')
  Future<Unit> updatePost(@Body() PostModel model);

  @DELETE('/delete')
  Future<Unit> deletePost(@Query("id") int ? id);

  @POST('/create')
  Future<Unit> addComment(@Body() CommentModel model);

  @POST('/likeUnlike')
  Future<bool> likeUnLikeComment(@Query("id") int ? id);

  @PUT('/update')
  Future<Unit> updateComment(@Body() CommentModel model);

  @DELETE('/delete')
  Future<Unit> deleteComment(@Query("id") int ? id);

}




