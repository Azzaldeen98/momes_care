
// part '';

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:retrofit/http.dart';

import '../../../../../core/constants/api_servers.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/data/models/base_response.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/remote/api_service.dart';
import '../../../domain/entities/Comment.dart';
import '../../models/comment_model.dart';

@RestApi(baseUrl:"${BASE_URL}/api/v1/Comment")
abstract class CommentRemoteDataSource{

  factory CommentRemoteDataSource() = CommentRemoteDataSourceImpl;

  @GET('/getAll')
  Future<List<CommentModel>> getAllComments();

  @GET('/getComment')
  Future<CommentModel> getComment(@Query("id") int ? id);

  @POST('/create')
  Future<Unit> addComment(@Body() CommentModel model);

  @POST('/likeUnlike')
  Future<bool> likeUnLikeComment(@Query("id") int ? id);

  @PUT('/update')
  Future<Unit> updateComment(@Body() CommentModel model);

  @DELETE('/delete')
  Future<Unit> deleteComment(@Query("id") int ? id);

}



 class CommentRemoteDataSourceImpl implements CommentRemoteDataSource{

  // final Dio dio;
   String? baseUrl;
  final RemoteDioService? remoteDioService ;
  CommentRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/Comment';
  }

  @override
  Future<List<CommentModel>> getAllComments() async {

    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getAll'));
    // final jsonMap=json.decode(_json);
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      print("jsonMap: ${response.result.toString()}");
      // List<dynamic> jsonList = json.decode(response.result!);
      List<CommentModel> Comments = (response.result as List).map((item) => CommentModel.fromJson(item)).toList();

      return Comments;
    }
    else
      throw ServerExecption();



  }

  @override
  Future<Unit> addComment(CommentModel model) async{
    final _json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/create',
    data: jsonEncode({
      "contant":model.contant,})
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
   Future<bool> likeUnLikeComment(int? id) async{

     final _json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/likeUnlike?id=${id}'));
     var response = BaseResponse.fromJson(_json!);
     if(response !=null && response.isSuccess){
       return response.result as bool;
     }
     else
       throw ServerExecption();

   }


  @override
  Future<Unit> deleteComment(int? id) async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.delete("${baseUrl}/delete?id=$id"));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
    return unit;
    }
    else
    throw ServerExecption();
  }

  @override
  Future<Unit> updateComment(CommentModel model)  async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.put('${baseUrl}/update',
        data: jsonEncode({
          "id":model.id,
          "contant":model.contant,})
    ),);
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<CommentModel> getComment(int? id) async {
    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getComment?id=$id'));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      // print("jsonMap: ${response.result.toString()}");
      return CommentModel.fromJson(response.result)  ;
    }
    else
      throw ServerExecption();
  }

}
