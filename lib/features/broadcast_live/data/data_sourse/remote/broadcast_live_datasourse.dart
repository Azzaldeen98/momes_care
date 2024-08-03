import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
import 'package:moms_care/core/data/models/base_response.dart';
import '../../models/broadcast_live_model.dart';

abstract class BroadcastLiveRemoteDataSource {
  Future<List<BroadcastLiveModel>> getMyBroadcastLives();
  Future<List<BroadcastLiveModel>> getActivesBroadcastLives();
  Future<Unit> addBroadcastLive(BroadcastLiveModel broadcastLive);
  Future<Unit>  updateBroadcastLive(BroadcastLiveModel broadcastLive);
  Future<Unit>  deleteBroadcastLive(int id);
  Future<Unit>  stopBroadcastLive(int id);

}

class BroadcastLiveRemoteDataSourceImpl extends BroadcastLiveRemoteDataSource {

  String? baseUrl;
  final RemoteDioService? remoteDioService ;
  BroadcastLiveRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/BroadcastLive';
  }
  @override
  Future<List<BroadcastLiveModel>> getMyBroadcastLives() async {
    final json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getMyBroadcastLives'),);
    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
      List<BroadcastLiveModel> broadcastLives = (response.result as List).map((item) => BroadcastLiveModel.fromJson(item)).toList();
      return broadcastLives;
    }
    else {
      throw ServerExecption();
    }
  }

  @override
  Future<List<BroadcastLiveModel>> getActivesBroadcastLives() async{
    final json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getActivesBroadcastLives'),);
    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
      List<BroadcastLiveModel> broadcastLives = (response.result as List).map((item) => BroadcastLiveModel.fromJson(item)).toList();
      return broadcastLives;
    }
    else
      throw ServerExecption();
  }
  @override
  Future<Unit> addBroadcastLive(BroadcastLiveModel broadcastLive) async{

    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.post('${baseUrl}/create',
            data: jsonEncode(broadcastLive.toJson())
        ),);
    return _getUnitResponseMessage(json);
  }
  @override
  Future<Unit> deleteBroadcastLive(int id) async{
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.delete('${baseUrl}/delete?id=${id}',));
    return _getUnitResponseMessage(json);
  }
  @override
  Future<Unit> updateBroadcastLive(BroadcastLiveModel broadcastLive)async{

    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.put('${baseUrl}/update',
        data: jsonEncode(broadcastLive.toJson())));
    return _getUnitResponseMessage(json);
  }

  @override
  Future<BroadcastLiveModel> getBroadcastLive(int id) async{

    final json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getOne?id=${id}'),);
    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
      return BroadcastLiveModel.fromJson(response.result);
    }
    else
      throw ServerExecption();
  }

  @override
  Future<Unit> stopBroadcastLive(int id) async{
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.put('${baseUrl}/InActiveBroadcastLive?id=${id}',));
    return _getUnitResponseMessage(json);
    // data: jsonEncode({"id":id }
  }

  Unit _getUnitResponseMessage(dynamic json){
    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
      return unit;
    } else {
      throw ServerExecption();
    }
  }








}


