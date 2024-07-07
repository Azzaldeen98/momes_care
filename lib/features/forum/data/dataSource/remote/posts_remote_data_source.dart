
// part '';

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:moms_care/features/forum/data/models/post_model.dart';
import 'package:retrofit/http.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entities/Post.dart';

@RestApi(baseUrl:"${baseURL}/Account")
abstract class PostRemoteDataSource{

  factory PostRemoteDataSource(Dio dio) = PostRemoteDataSourceImpl;

  @GET('/getAllPosts')
  Future<List<PostModel>> getAllPosts();

  @POST('/addPost')
  Future<Unit> addPost(@Body() PostModel model);

  @PUT('/updatePost')
  Future<Unit> updatePost(@Body() PostModel model);

  @DELETE('/deletePost')
  Future<Unit> deletePost(@Query("id") int ? id);

}



 class PostRemoteDataSourceImpl implements PostRemoteDataSource{

  final Dio dio;
   String? baseUrl;
  PostRemoteDataSourceImpl(this.dio,{this.baseUrl}){
    baseUrl ??= baseURL;
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    return  Future.value([PostModel(id: 1,title: "A",body: "Body",likes: 10,publishedAt: DateTime.now()),
      PostModel(id: 2,title: "B",body: "Body",likes: 10,publishedAt: DateTime.now()),
      PostModel(id: 3,title: "C",body: "Body",likes: 10,publishedAt: DateTime.now()),
      PostModel(id: 4,title: "D",body: "Body",likes: 10,publishedAt: DateTime.now()),
      PostModel(id: 5,title: "E",body: "Body",likes: 10,publishedAt: DateTime.now())]);
  }

  @override
  Future<Unit> addPost(PostModel model) async{
    // TODO: implement addPost
    throw UnimplementedError();
  }



  @override
  Future<Unit> deletePost(int? id) async{
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel model)  async{
    // TODO: implement updatePost
    throw UnimplementedError();
  }

}
