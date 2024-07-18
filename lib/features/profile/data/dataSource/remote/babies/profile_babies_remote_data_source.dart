import 'dart:convert';
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/forum/data/models/post_model.dart';
import 'package:moms_care/features/profile/data/models/baby_model.dart';
import 'package:moms_care/features/profile/data/models/profile_model.dart';
import 'package:retrofit/http.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';

part 'profile_babies_remote_data_source_impl.dart';



@RestApi(baseUrl:"${BASE_URL}/api/v1/Baby")
abstract class BabiesRemoteDataSource{

  factory BabiesRemoteDataSource() = BabiesRemoteDataSourceImpl;


  @GET('/getAll')
  Future<List<BabyModel>> getAll();

  @GET('/getOne')
  Future<BabyModel> getOne(@Query("BabyId") int ? id);

  @POST('/create')
  Future<Unit> create(@Body() BabyModel ? model);

  @PUT('/update')
  Future<Unit> update(@Body() BabyModel ? model);

  @DELETE('/delete')
  Future<Unit> delete(@Query("id") int ? id);



}


