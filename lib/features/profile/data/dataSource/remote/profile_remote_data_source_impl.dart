
 part of 'profile_remote_data_source.dart';



 class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{

   ProfileRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/Profile';
  }

  String? baseUrl;
  final RemoteDioService? remoteDioService ;

  @override
  Future<ProfileModel> getInfo() async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getInfo'));

    print("_json77: ${_json.toString()}");
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      print("jsonMap: ${response.result.toString()}");
      // List<dynamic> jsonList = json.decode(response.result!);
      return ProfileModel.fromJson(response.result) ;
    }
    else
      throw ServerExecption();

  }

  @override
  Future<List<PostModel>> getMyPosts() async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getMyPosts'));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      print("jsonMap: ${response.result.toString()}");
      List<PostModel> posts = (response.result as List).map((item) => PostModel.fromJson(item)).toList();
      return posts;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<Unit> updateEmail(String? email) async {

    final json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/updateEmail',
        data: jsonEncode({"email":email,})
    ),);
    return _getUpdateResponseMessage(json);
  }

  @override
  Future<Unit> updateName(String? name) async{

    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.post('${baseUrl}/updateName',
        data: jsonEncode({"name":name,})
    ),);
    return _getUpdateResponseMessage(json);
  }



  @override
  Future<Unit> updatePassword({String? currentPassword, String? newPassword}) async {
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.post('${baseUrl}/updatePassword',
            data: jsonEncode({
            "currentPassword":currentPassword,
            "newPassword":newPassword,
            })
        ),);
    return _getUpdateResponseMessage(json);
  }

   Unit _getUpdateResponseMessage(dynamic json){

     print("UpdateResponse: $json");
     var response = BaseResponse.fromJson(json!);
     // print("UpdateResponse: ${response.result}");
     if(response !=null && response.isSuccess){
       return unit;
     } else
       throw ServerExecption();
   }

}
