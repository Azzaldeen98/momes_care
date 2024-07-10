import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_servers.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/remote/api_service.dart';
import '../../../../core/server/header_server.dart';

abstract class MomsCareRemoteDataSource {
  Future<List<String>> getItems();
}

class MomsCareRemoteDataSourceImpl extends MomsCareRemoteDataSource {

  String? baseUrl;
  final RemoteDioService? remoteDioService ;
  MomsCareRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/MomsCare';
  }
  @override
  Future<List<String>> getItems() async {

    throw UnimplementedError();
  }
}


