
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
import 'package:moms_care/core/remote/gemini_ai_server/gemini_api_client.dart';
import 'package:moms_care/core/server/header_server.dart';
import 'package:moms_care/features/dashboard/data/models/care_type_model.dart';

abstract class CareTypeRemoteDataSource {
  Future<List<CareTypeModel>> getAll();
  Future<List<CareTypeModel>> getAllWithDailyCareTimes();
  Future<Unit> create(CareTypeModel model);
  Future<Unit> update(CareTypeModel model);
  Future<Unit> delete(int id);
}

class CareTypeRemoteDataSourceImpl extends CareTypeRemoteDataSource {

  String? baseUrl;
  final RemoteDioService? remoteDioService ;

  CareTypeRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/CareType';}

  @override
  Future<List<CareTypeModel>> getAll() async{
    final json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getAll'),);

    return remoteDioService?.checkResponse(json,(response){
      List<CareTypeModel> items = (response.result as List).map((item) => CareTypeModel.fromJson(item)).toList();
      return items;
    });
  }

  @override
  Future<List<CareTypeModel>> getAllWithDailyCareTimes() async{
    final json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getAllWithDailyCareTimes'),);
    return remoteDioService?.checkResponse(json,(response){
      List<CareTypeModel> items = (response.result as List).map((item) => CareTypeModel.fromJson(item)).toList();
      return items;
    });
  }
  @override
  Future<Unit> create(CareTypeModel model) async{
    final json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/create',
        data:jsonEncode( model.toJson()) ),);
    return remoteDioService?.checkResponse(json,(response)=> unit);
  }

  @override
  Future<Unit> update(CareTypeModel model) async{
    final json = await remoteDioService?.executeWithToken((dio) => dio.put('${baseUrl}/update',
        data:jsonEncode( model.toJson()) ),);
    return remoteDioService?.checkResponse(json,(response)=> unit);
  }

  @override
  Future<Unit> delete(int id) async{
    final json = await remoteDioService?.executeWithToken((dio) => dio.delete('${baseUrl}/delete?id=$id'),);
    return remoteDioService?.checkResponse(json,(response)=> unit);
  }


}