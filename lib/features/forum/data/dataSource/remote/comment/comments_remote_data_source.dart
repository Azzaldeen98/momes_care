
// part '';

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/data/models/comment_model.dart';
import 'package:retrofit/http.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
part 'comments_remote_data_source_impl.dart';


@RestApi(baseUrl:"${BASE_URL}/api/v1/Comment")
abstract class CommentRemoteDataSource{

  factory CommentRemoteDataSource() = CommentRemoteDataSourceImpl;

  @GET('/getAll')
  Future<List<CommentModel>> getAllComments();

  @GET('/getComment')
  Future<CommentModel> getComment(@Query("id") int  id);

  @POST('/create')
  Future<Unit> addComment(@Body() CommentModel model);

  @POST('/likeUnlike')
  Future<bool> likeUnLikeComment(@Query("id") int ? id);

  @PUT('/update')
  Future<Unit> updateComment(@Body() CommentModel model);

  @DELETE('/delete')
  Future<Unit> deleteComment(@Query("id") int ? id);

}


