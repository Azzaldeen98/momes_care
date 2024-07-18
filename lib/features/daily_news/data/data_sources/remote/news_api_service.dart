
import 'package:retrofit/retrofit.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:dio/dio.dart';
import '../../models/article.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl:newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;
  
  @GET('/top-headlines')
  // @Headers({
  //   'Authorization': 'Bearer YOUR_API_KEY',
  //   'Content-Type': 'application/json',
  // })
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("apiKey") String ? apiKey,
    @Query("country") String ? country,
    @Query("category") String ? category,
  });
}

