import 'package:dartz/dartz.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_media.dart';
import 'package:moms_care/features/daily_news/domain/entities/article.dart';
import 'package:moms_care/features/daily_news/domain/repository/article_repository.dart';

import 'package:moms_care/core/error/faiture.dart';
import '../repositories/courses_repository.dart';

class GetAllCourseItemsUseCase {
  
  final CoursesRepository _repository;

  GetAllCourseItemsUseCase(this._repository);
  
  @override
  Future<Either<Failure,List<CourseMedia>>> call(int courseId) async {
    print("GetAllCourseItemsEvent:: ${courseId}");
    var res= await _repository.getCourseMedias(courseId);
    print("getCourseMedias:: ${res.length}");
    return res;
  }
  
}