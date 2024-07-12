
// part '';

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:moms_care/features/forum/data/models/post_model.dart';
import 'package:retrofit/http.dart';

import '../../../../../core/constants/api_servers.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/data/models/base_response.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/remote/api_service.dart';
import '../../../domain/entities/Post.dart';

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

}



 class PostRemoteDataSourceImpl implements PostRemoteDataSource{

  // final Dio dio;
   String? baseUrl;
  final RemoteDioService? remoteDioService ;
  PostRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/Post';
  }

  @override
  Future<List<PostModel>> getAllPosts() async {

    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getAll'));
    // final jsonMap=json.decode(_json);
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      print("jsonMap: ${response.result.toString()}");
      // List<dynamic> jsonList = json.decode(response.result!);
      List<PostModel> posts = (response.result as List).map((item) => PostModel.fromJson(item)).toList();

      return posts;
    }
    else
      throw ServerExecption();



    return  Future.value([PostModel(id: 1,title: "A",body: "Body",likes: 10,publishedAt: DateTime.now()),
      PostModel(id: 2,title: "B",body: "Body",likes: 10,publishedAt: DateTime.now()),
      PostModel(id: 3,title: "C",body: "Body",likes: 10,publishedAt: DateTime.now()),
      PostModel(id: 4,title: "D",body: "Body",likes: 10,publishedAt: DateTime.now()),
      PostModel(id: 5,title: "E",body: "Body",likes: 10,publishedAt: DateTime.now())]);
  }

  @override
  Future<Unit> addPost(PostModel model) async{
    final _json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/create',
    data: jsonEncode({
      "title":model.title,
      "body":model.body,})
    ),);

    print("response44 $_json");
    var response = BaseResponse.fromJson(_json!);
    print("response44: ${response.result}");
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();

  }

   @override
   Future<bool> likeUnLikePost(int? id) async{

     final _json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/likeUnlike?id=${id}'));
     var response = BaseResponse.fromJson(_json!);
     if(response !=null && response.isSuccess){
       return response.result as bool;
     }
     else
       throw ServerExecption();

   }


  @override
  Future<Unit> deletePost(int? id) async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.delete("${baseUrl}/delete?id=$id"));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
    return unit;
    }
    else
    throw ServerExecption();
  }

  @override
  Future<Unit> updatePost(PostModel model)  async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.put('${baseUrl}/update',
        data: jsonEncode({
          "id":model.id,
          "title":model.title,
          "body":model.body,})
    ),);
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<PostModel> getPost(int? id) async {
    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getPost?id=$id'));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      // print("jsonMap: ${response.result.toString()}");
      return PostModel.fromJson(response.result)  ;
    }
    else
      throw ServerExecption();
  }

}
