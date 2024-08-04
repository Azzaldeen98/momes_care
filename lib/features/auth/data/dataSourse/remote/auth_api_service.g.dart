// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  String? baseUrl;
  final RemoteDioService? remoteDioService ;

  AuthRemoteDataSourceImpl({ this.remoteDioService, this.baseUrl}) {
    baseUrl ??=BASE_URL;
    baseUrl='${baseUrl}api/v1/Auth';
  }
  @override
  Future<Auth> signIn(Map<String, dynamic> model) async {

    final _json = await remoteDioService?.execute((dio) => dio.post('$baseUrl/SignIn',
        data: jsonEncode(model)));
    // final jsonMap=json.decode(_json);
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.result!=null){
      return Auth(userInfo: UserInfo.fromJson(response.result!));
    }
    else
       throw ServerExecption();
  }
  @override
  Future<Unit> signUp(Map<String, dynamic> model) async {

    final _json = await remoteDioService?.execute((dio) => dio.post('${baseUrl}/SignUp',
        data: jsonEncode(model)));
    var response = BaseResponse.fromJson(_json);
    if(response !=null && response.isSuccess! ){
      return Future.value(unit);
    }else {
      throw ServerExecption();
    }

  }
  @override
  Future<Unit> refreshFCMToken(String fcmToken) async{
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.post('${baseUrl}/initializeFCMToken',
        data: jsonEncode({
          "Token":fcmToken,
        })));

    var response = BaseResponse.fromJson(json);
    if(response !=null && response.isSuccess! ){
      return Future.value(unit);
    }else {
      throw ServerExecption();
    }
  }
}
