import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';

import '../../helpers/cache_helper.dart';

class ApiService {

  ApiService(this._dio,this.cancelToken);

  final CancelToken cancelToken;
  final Dio _dio ;

  Future<String> execute(Function(Dio dio) apiCall) async {
    try {
      final response = await apiCall(_dio,);
      if (response.statusCode == 200) {
        if (response.data is String) {
          return response.data;
        } else {
          return json.encode(response?.data!); // Convert Map to JSON string
        }

      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception('$e');
    }
    catch (e) {
      throw Exception('Failed to execute request: $e');
    }
  }
  Future<String> executeWithToken(Function(Dio dio) apiCall) async {
    try {
      var token = CacheHelper.getString(AUTH_TOKEN_CACHED);
      if (token == null)
        throw Exception("not Authorize !!");

      // _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers={
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_KEY',
      };

      final response = await apiCall(_dio);
      if (response != null && response.statusCode == 200) {
        print("response is Success: ${response.data}");
        if (response.data is String) {
          return response?.data; // No need for casting
        } else {
          return json.encode(response?.data!); // Convert Map to JSON string
        }

      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }

    } on SocketException catch (e) {

      throw Exception('$e');
    }
    catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          print('Request failed with status code: ${error.response!.statusCode}');
          if(error.response!.statusCode == 401) {

          }

        }
      }
      throw Exception('Failed to execute request: $error');

    }
  }

}