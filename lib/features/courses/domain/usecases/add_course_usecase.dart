import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';



import 'package:moms_care/core/error/faiture.dart';
import '../repositories/courses_repository.dart';

class AddCourseUsecase {
  
  final CoursesRepository _repository;

  AddCourseUsecase(this._repository);
  
  @override
  Future<Either<Failure,Unit>> call(Course course) async {
    return await _repository.addCourse(course);
  }
  
}