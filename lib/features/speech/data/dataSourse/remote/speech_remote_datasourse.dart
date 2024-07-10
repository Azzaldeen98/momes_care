import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../core/constants/api_servers.dart';
import '../../../../../core/data/models/base_response.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/remote/api_service.dart';
import '../../../../../core/server/header_server.dart';

abstract class SpeechRemoteDataSource {
  Future<String> askAi(String text);
}

class SpeechRemoteDataSourceImpl extends SpeechRemoteDataSource {

  String? baseUrl;
  final RemoteDioService? remoteDioService ;
  SpeechRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/Speech';
  }
  @override
  Future<String> askAi(String text) async{
    final _json = await remoteDioService?.executeWithToken((dio) =>
        dio.post('${baseUrl}/askAi', data: jsonEncode({"text":text,})),
    );
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return response.result;
    }
    else
      throw ServerExecption();
  }


}


