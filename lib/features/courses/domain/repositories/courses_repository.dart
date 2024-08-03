import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';

abstract class CoursesRepository{

  Future<Either<Failure, List<Course>>> getAllCourses();
  Future<Either<Failure, List<CourseItem>>> getCourseItems(int courseId);
  Future<Either<Failure, Unit>> addCourse(Course course);
  Future<Either<Failure, Unit>> updateCourse(Course course);
  Future<Either<Failure, Unit>> deleteCourse(int id);
  Future<Either<Failure, String>> uploadFile(File file);
  Future<Either<Failure, Unit>> addCourseItem(CourseItem CourseItem);
  Future<Either<Failure, Unit>> updateCourseItem(CourseItem CourseItem);
  Future<Either<Failure, Unit>> deleteCourseItem(int id);


}