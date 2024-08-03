import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/server/header_server.dart';

import 'package:moms_care/core/helpers/cache_helper.dart';

class RemoteDioService {

  CancelToken? cancelToken;
  final Dio _dio ;
  final Duration _connectTimeout = const Duration(seconds: 30);

  RemoteDioService(this._dio){
    cancelToken=CancelToken();
  }

  Future<dynamic> call(Function(Dio dio) apiCall,Dio _dio) async {

    try {

      _dio.options.connectTimeout=_connectTimeout;
      final response = await apiCall(_dio);
      print('Request_with_status: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if(response.statusCode == 401) {
        throw AuthenticationException();
      } else {
        printError(info: 'Request failed with status: ${response.statusCode}');
        throw ServerExecption();
      }
    }catch(e){
      printError(info: '#Exception: ${e}');
      throw ServerExecption();
    }
  }

  Future<dynamic?> execute(Function(Dio dio) apiCall) async {
    // _dio.options.headers=HeaderServer.header;
    var response= await call(apiCall,_dio);
    return  response;

  }
  Future<dynamic?> executeWithToken(Function(Dio dio) apiCall) async {

    _dio.options.headers=HeaderServer.headerWithToken;

    var response= await call(apiCall,_dio);
    return  response; //json.decode(response!);

      // var token = CacheHelper.getString(AUTH_TOKEN_CACHED);
      // if (token == null)
      //   throw Exception("not Authorize !!");
      //
      // _dio.options.headers={
      //   'Content-Type': 'application/json',
      //   'Authorization': 'Bearer YOUR_API_KEY',
      // };



  }

  dynamic  checkResponse(dynamic json,dynamic Function(BaseResponse) callBack){

    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
      return callBack(response);
    }
    else {
      throw ServerExecption();
    }
  }
  Unit unitResponseMessage(dynamic json){

    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
      return unit;
    } else {
      throw ServerExecption();
    }
  }

}