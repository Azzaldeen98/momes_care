import 'package:dartz/dartz.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/daily_news/domain/entities/article.dart';
import 'package:moms_care/features/daily_news/domain/repository/article_repository.dart';

import 'package:moms_care/core/error/faiture.dart';
import '../repositories/courses_repository.dart';

class GetAllCoursesUseCase {
  
  final CoursesRepository _repository;

  GetAllCoursesUseCase(this._repository);
  
  @override
  Future<Either<Failure,List<Course>>> call() async {
    return await _repository.getAllCourses();
  }
  
}