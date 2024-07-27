
part of 'posts_remote_data_source.dart';


class PostRemoteDataSourceImpl implements PostRemoteDataSource{

  // final Dio dio;
  String? baseUrl;
  final RemoteDioService? remoteDioService ;
  PostRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/Post';
  }

  @override
  Future<List<PostModel>> getAllPosts() async {

    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getAll'));
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
  Future<Unit> addPost(PostModel model) async{
    final _json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/create',
        data: jsonEncode({
          "title":model.title,
          "body":model.body,})
    ),);

    print("response44 $_json");
    var response = BaseResponse.fromJson(_json!);
    print("response44: ${response.result}");
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();

  }

  @override
  Future<bool> likeUnLikePost(int? id) async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.post('${baseUrl}/likeUnlike?id=${id}'));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return response.result as bool;
    }
    else
      throw ServerExecption();

  }

  @override
  Future<Unit> deletePost(int? id) async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.delete("${baseUrl}/delete?id=$id"));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<Unit> updatePost(PostModel model)  async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.put('${baseUrl}/update',
        data: jsonEncode({
          "id":model.id,
          "title":model.title,
          "body":model.body,})
    ),);
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<PostModel> getPost(int? id) async {
    final _json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getPost?id=$id'));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return PostModel.fromJson(response.result)  ;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<Unit> addComment(CommentModel model) async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.post('${BASE_URL}api/v1/Comment/create',
        data: jsonEncode({
          "postId":model.postId,
          "contant":model.contant,})
    ),);

    print("response44 $_json");
    var response = BaseResponse.fromJson(_json!);
    print("response44: ${response.result}");
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<bool> likeUnLikeComment(int? id) async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.post('${BASE_URL}api/v1/Comment/likeUnlike?id=${id}'));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return response.result as bool;
    }
    else
      throw ServerExecption();

  }

  @override
  Future<Unit> deleteComment(int? id) async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.delete("${BASE_URL}api/v1/Comment/delete?id=$id"));
    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<Unit> updateComment(CommentModel model)  async{

    final _json = await remoteDioService?.executeWithToken((dio) => dio.put('${BASE_URL}api/v1/Comment/update',
        data: jsonEncode({
          "id":model.id,
          "contant":model.contant,})
    ),);

    var response = BaseResponse.fromJson(_json!);
    if(response !=null && response.isSuccess){
      return unit;
    }
    else
      throw ServerExecption();
  }

}


