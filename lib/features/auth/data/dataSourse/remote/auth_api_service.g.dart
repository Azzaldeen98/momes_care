// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  // final Dio _dio;
  String? baseUrl;
   final RemoteDioService? remoteDioService ;

  AuthRemoteDataSourceImpl({ this.remoteDioService, this.baseUrl}) {
    baseUrl ??='${BASE_URL}';
    baseUrl='${baseUrl}api/v1/Auth';
  }



  @override
  Future<Auth> signIn(Map<String, dynamic> model) async {

    final _json = await remoteDioService?.execute((dio) => dio.post('${baseUrl}/SignIn',
        data: jsonEncode(model)));
    // final jsonMap=json.decode(_json);
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.result!=null){
      print("jsonMap: ${response.result.toString()}");
      return Auth(userInfo: UserInfo.fromJson(response.result!));
    }
    else
       throw ServerExecption();

    // final _extra = <String, dynamic>{};
    // final queryParameters = <String, dynamic>{};
    // final _headers = <String, dynamic>{};
    // final _data = <String, dynamic>{};
    // _data.addAll(model);
    // final _result =
    //     await _dio.fetch<Map<String, dynamic>>(_setStreamType<Auth>(Options(
    //   method: 'POST',
    //   headers: _headers,
    //   extra: _extra,
    // )
    //         .compose(
    //           _dio.options,
    //           '/SignIn',
    //           queryParameters: queryParameters,
    //           data: _data,
    //         )
    //         .copyWith(
    //             baseUrl: _combineBaseUrls(
    //           _dio.options.baseUrl,
    //           baseUrl,
    //         ))));
  //   final _value = Auth.fromJson(_result.data!);
  //   return _value;
  }

  @override
  Future<Unit> signUp(Map<String, dynamic> model) async {

    final _json = await remoteDioService?.execute((dio) => dio.post('${baseUrl}/SignUp',
        data: jsonEncode(model)));
    print("dio: ${_json.toString()}");
    var response = BaseResponse.fromJson(_json);
    if(response !=null && response.isSuccess! ){
      print("signUp Successfully");
      return Future.value(unit);
    }else
      throw ServerExecption();

    // final _extra = <String, dynamic>{};
    // final queryParameters = <String, dynamic>{};
    // final _headers = <String, dynamic>{};
    // final _data = <String, dynamic>{};
    // _data.addAll(model);
    // final _result =
    //     await _dio.fetch<Map<String, dynamic>>(_setStreamType<Auth>(Options(
    //   method: 'POST',
    //   headers: _headers,
    //   extra: _extra,
    // )
    //         .compose(
    //           _dio.options,
    //           '/SignUp',
    //           queryParameters: queryParameters,
    //           data: _data,
    //         )
    //         .copyWith(
    //             baseUrl: _combineBaseUrls(
    //           _dio.options.baseUrl,
    //           baseUrl,
    //         ))));
    // final _value = Auth.fromJson(_result.data!);
    // return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
