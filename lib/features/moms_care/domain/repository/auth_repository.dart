import 'package:dio/dio.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/features/daily_news/domain/entities/article.dart';
import 'package:moms_care/features/moms_care/domain/entities/signup_entity.dart';

abstract class AuthRepository {
  // API methods

  Future<DataState<ResponseBody>> signUp(SignUpEntity  entity);

}