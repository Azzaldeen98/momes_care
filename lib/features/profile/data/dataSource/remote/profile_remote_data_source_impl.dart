
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

     try {

       final json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getInfo'));
       var response = BaseResponse.fromJson(json!);
       if(response !=null && response.isSuccess){
         return ProfileModel.fromJson(response.result) ;
       }
       else {
         throw ServerExecption();
       }

     }catch(e){
       throw Exception(e);
     }

  }

   @override
   Future<ProfileModel> getAuthorInfo(String userId) async{
     final json = await remoteDioService?.executeWithToken((dio) => dio.get('$baseUrl/getAuthorInfo?userId=$userId'));
     var response = BaseResponse.fromJson(json!);
     if(response !=null && response.isSuccess){
       return ProfileModel.fromJson(response.result) ;
     }
     else {
       throw ServerExecption();
     }
   }
  @override
  Future<List<PostModel>> getMyPosts() async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getMyPosts'));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      List<PostModel> posts = (response.result as List).map((item) => PostModel.fromJson(item)).toList();
      return posts;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<Unit> updateEmail(String? email) async {

    final json = await remoteDioService?.executeWithToken((dio) => dio.put('${baseUrl}/updateEmail',
        data: jsonEncode({"newEmail":email,})
    ),);
    return _getUpdateResponseMessage(json);
  }

  @override
  Future<Unit> updateName(String? name) async{

    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.put('${baseUrl}/updateName',
        data: jsonEncode({"name":name,})
    ),);
    return _getUpdateResponseMessage(json);
  }



  @override
  Future<Unit> changePassword({String? currentPassword, String? newPassword}) async {
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.put('${baseUrl}/changePassword',
            data: jsonEncode({
            "currentPassword": currentPassword,
            "newPassword": newPassword
            })
        ),);
    return _getUpdateResponseMessage(json);
  }
   Future<void> _deleteFileFromFirebaseStorage(String oldUrlMedia) async{

   }
  @override
  Future<String> uploadImageToStorage(File image,String? oldUrl) async{
    try {
      if(oldUrl!=null) {
        await FirebaseStorageActions.deleteFile(fileUrl: oldUrl!);
      }

      return  await FirebaseStorageActions.uploadFile(file:image ,folder:PROFILE_ID);

    } on FirebaseException catch(e){
        throw FirebaseException(plugin: e.plugin,message: e.message);
    } catch(e){
      throw Exception(e);
    }


  }

  @override
  Future<Unit> updateImage(String urlImage) async{
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.put('${baseUrl}/updateImage',
            data: jsonEncode({
              "id": 0,
              "urlImage": urlImage
            })
        ),);
    return _getUpdateResponseMessage(json);
  }


   Unit _getUpdateResponseMessage(dynamic json){

     var response = BaseResponse.fromJson(json!);
     // print("UpdateResponse: ${response.result}");
     if(response !=null && response.isSuccess){
       return unit;
     } else
        throw ServerExecption();
   }



}
