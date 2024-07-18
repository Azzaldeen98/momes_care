import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
import 'package:moms_care/core/remote/gemini_ai_server/gemini_api_client.dart';
import 'package:moms_care/core/server/header_server.dart';

abstract class SpeechRemoteDataSource {
  Future<String> askAi(String text);
}

class SpeechRemoteDataSourceImpl extends SpeechRemoteDataSource {

  SpeechRemoteDataSourceImpl({required this.geminiApiClient});

  final GeminiApiClient? geminiApiClient ;

  @override
  Future<String> askAi(String text) async{
    print(text);
    return await geminiApiClient!.generateText(text);
  }


}


