import 'dart:convert';
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:moms_care/features/forum/data/models/post_model.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:retrofit/http.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
import '../../../../forum/domain/entities/Post.dart';

part 'profile_remote_data_source_impl.dart';



@RestApi(baseUrl:"${BASE_URL}/api/v1/Profile")
abstract class ProfileRemoteDataSource{

  factory ProfileRemoteDataSource() = ProfileRemoteDataSourceImpl;

  @GET('/getInfo')
  Future<ProfileModel> getInfo();

  @GET('/getMyPosts')
  Future<List<PostModel>> getMyPosts();

  @PUT('/updateName')
  Future<Unit> updateName(@Query("name") String ? name);

  @PUT('/updateEmail')
  Future<Unit> updateEmail(@Query("email") String ? email);


  @PUT('/updatePassword')
  Future<Unit> updatePassword({
    @Query("currentPassword") String ? currentPassword,
    @Query("newPassword") String ? newPassword,
});

}


