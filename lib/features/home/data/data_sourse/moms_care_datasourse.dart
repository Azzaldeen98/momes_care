import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
import 'package:moms_care/core/server/header_server.dart';

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


