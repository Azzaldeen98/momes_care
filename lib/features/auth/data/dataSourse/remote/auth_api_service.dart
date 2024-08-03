import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import 'package:moms_care/features/auth/domain/entities/user_info.dart';

import 'package:retrofit/retrofit.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
import '../../../domain/entities/auth.dart';



 part 'auth_api_service.g.dart';


@RestApi(baseUrl:"${BASE_URL}api/v1/Auth")
abstract class AuthRemoteDataSource {

  factory AuthRemoteDataSource() = AuthRemoteDataSourceImpl;

  @POST('/SignIn')
  Future<Auth> signIn(@Body() Map<String, dynamic> model);
  @POST('/SignUp')
  Future<Unit> signUp(@Body() Map<String, dynamic> model);

  @POST('/initializeFCMToken')
  Future<Unit> refreshFCMToken(String fcmToken);
}



// class AuthApiServiceImpl implements AuthApiService {
//
//   AuthApiServiceImpl(
//       this._dio, {
//         this.baseUrl,
//       }) ;
//
//   final Dio _dio;
//   final String? baseUrl;
//   final String api="api/v1/Auth";
//
//   @override
//   Future<Auth> signIn(Map<String, dynamic> request) async {
//     final _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     _data.addAll(request);
//     final resonse = await _dio.fetch<Map<String, dynamic>>(
//         _setStreamType<UserInfo>(Options(
//           method: 'POST',
//           headers: _headers,
//           extra: _extra,
//         )
//             .compose(
//           _dio.options,
//           '${api}/SignIn',
//           queryParameters: queryParameters,
//           data: _data,
//         )
//             .copyWith(
//             baseUrl: _combineBaseUrls(
//               _dio.options.baseUrl,
//               baseUrl,
//             ))));
//
//     if (resonse.statusCode == 200 || resonse.statusCode == 201) {
//       return Auth.fromJson({'userInfo': resonse});
//     } else {
//       throw ServerExecption();
//     }
//
//   }
//
//   @override
//   Future<Auth> signUp(Map<String, dynamic>  model) async {
//     final _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     _data.addAll(model);
//     final resonse =
//     await _dio.fetch(
//         _setStreamType(Options(
//           method: 'POST',
//           headers: _headers,
//           extra: _extra,
//         ).compose(
//           _dio.options,
//           '/SignUp',
//           queryParameters: queryParameters,
//           data: _data,
//         )
//             .copyWith(
//             baseUrl: _combineBaseUrls(
//               _dio.options.baseUrl,
//               baseUrl,
//             ))));
//
//     if (resonse.statusCode == 200 || resonse.statusCode == 201) {
//       return Future.value(Auth());
//     } else {
//       throw ServerExecption();
//     }
//     // final _value = UserInfo.fromJson(_result.data!);
//     // final httpResponse = HttpResponse(_value, _result);
//     // return httpResponse;
//   }
//
//   RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
//     if (T != dynamic &&
//         !(requestOptions.responseType == ResponseType.bytes ||
//             requestOptions.responseType == ResponseType.stream)) {
//       if (T == String) {
//         requestOptions.responseType = ResponseType.plain;
//       } else {
//         requestOptions.responseType = ResponseType.json;
//       }
//     }
//     return requestOptions;
//   }
//
//   String _combineBaseUrls(
//       String dioBaseUrl,
//       String? baseUrl,
//       ) {
//     if (baseUrl == null || baseUrl.trim().isEmpty) {
//       return dioBaseUrl;
//     }
//
//     final url = Uri.parse(baseUrl);
//
//     if (url.isAbsolute) {
//       return url.toString();
//     }
//
//     return Uri.parse(dioBaseUrl).resolveUri(url).toString();
//   }
// }