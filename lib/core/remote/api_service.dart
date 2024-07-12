import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/server/header_server.dart';

import '../../helpers/cache_helper.dart';

class RemoteDioService {

  RemoteDioService(this._dio){
    cancelToken=CancelToken();
  }

  CancelToken? cancelToken;
  final Dio _dio ;

  Future<dynamic> call(Function(Dio dio) apiCall,Dio _dio) async {

    print( 'Rest_Api_Execute');
    try {
      final response = await apiCall(_dio,);

      print('Request_with_status: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
        // if (response.data is String) {
        //   return response.data;
        // } else {
        //   return json.encode(response?.data!); // Convert Map to JSON string
        // }
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
    return  response; // json.decode(response!);

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

}