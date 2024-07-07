import 'package:dartz/dartz.dart';
import 'package:moms_care/features/auth/data/models/signup_model.dart';
import 'package:moms_care/features/auth/domain/entities/user_info.dart';
import 'package:moms_care/features/daily_news/data/models/article.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/server/api_services_options.dart';
import '../../../domain/entities/auth.dart';



part 'auth_api_service.g.dart';


@RestApi(baseUrl:"${baseURL}/Account")
abstract class AuthApiService {

  factory AuthApiService(Dio dio) = _AuthApiService;
  
  @POST('/signIn')
  Future<Auth> signIn(@Body() Map<String, dynamic> model);
  @POST('/signUp')
  Future<Auth> signUp(@Body() Map<String, dynamic> model );
}



// import 'package:json_annotation/json_annotation.dart';
//
// part 'article_model.g.dart';
//
// @JsonSerializable()
// class ArticleModel {
//   final String title;
//   final String description;
//   final String url;
//   final String urlToImage;
//   final String publishedAt;
//   final String content;
//
//   ArticleModel({
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });
//
//   factory ArticleModel.fromJson(Map<String, dynamic> json) =>
//       _$ArticleModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
// }
