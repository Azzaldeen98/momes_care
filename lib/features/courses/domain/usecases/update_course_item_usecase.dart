import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';



import 'package:moms_care/core/error/faiture.dart';
import '../repositories/courses_repository.dart';

class UpdateCourseItemUseCase {

  final CoursesRepository _repository;

  UpdateCourseItemUseCase(this._repository);

  @override
  Future<Either<Failure,Unit>> call(CourseItem courseItem) async {
    return await _repository.updateCourseItem(courseItem);
  }

}