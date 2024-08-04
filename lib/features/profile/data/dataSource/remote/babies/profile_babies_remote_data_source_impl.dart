
 part of 'profile_babies_remote_data_source.dart';

 class BabiesRemoteDataSourceImpl implements BabiesRemoteDataSource{
   String? baseUrl;
   final RemoteDioService? remoteDioService ;
   BabiesRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/Baby';
  }

  @override
  Future<List<BabyModel>> getAll()async {
     final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getAll'));
     var response = BaseResponse.fromJson(_json!);
     if(response !=null && response.isSuccess){;
     List<BabyModel> items = (response.result as List).map((item) => BabyModel.fromJson(item)).toList();
     return items;
     }
     else {
       throw ServerExecption();
     }
  }
  @override
  Future<BabyModel> getOne(int? id) async {

    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getOne?BabyId=${id}'));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
    return BabyModel.fromJson(response.result) ;
    }
    else {
      throw ServerExecption();
    }
  }
  @override
  Future<Unit> create(BabyModel? model) async {

     try {
       var jsonModel=model!.getJsonCreateBaby();
       final json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/create',
               data: jsonEncode(jsonModel)),);
       return _getUpdateResponseMessage(json);

     } on ServerExecption {
       printError(info:"ServerExecption:");
       throw ServerExecption();
     }on Exception {
       printError(info:"Catch_Error:");
       throw Exception();
     }
  }
  @override
  Future<Unit> update(BabyModel? model) async {

   try{
          final json = await remoteDioService?.executeWithToken((dio) =>
              dio.put('${baseUrl}/update', data: jsonEncode(model!.toJson())));
          return _getUpdateResponseMessage(json);
   } on ServerExecption {
     printError(info:"ServerExecption:");
     throw ServerExecption();
   }on Exception {
     printError(info:"Catch_Error:");
     throw Exception();
   }

  }
  @override
  Future<Unit> delete(int? id) async{
  final json = await remoteDioService?.executeWithToken((dio) => dio.delete('${baseUrl}/delete?id=${id}'));
  return _getUpdateResponseMessage(json);
  }
  Unit _getUpdateResponseMessage(dynamic json){
    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
     return unit;
    } else {
      throw ServerExecption();
    }
  }

}
