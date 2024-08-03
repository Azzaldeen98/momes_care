import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/features/courses/data/models/course_item_model.dart';
import 'package:moms_care/features/courses/data/models/course_model.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';
import '../../domain/repositories/courses_repository.dart';

import '../data_sourse/remote/courses_datasourse.dart';

class CoursesRepositoryImpl extends CoursesRepository {

  CoursesRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  final CourseRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;



  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async{
    return await safeExecuteTaskWithNetworkCheck<List<Course>>(networkInfo,() async{
      var response= await remoteDataSource.getAllCourses();
      return  response.map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, String>> uploadFile(File file) async{
    return await safeExecuteTaskWithNetworkCheck<String>(networkInfo,() async{
      return await remoteDataSource.uploadFile(file);
    });
  }

  @override
  Future<Either<Failure, Unit>> addCourse(Course course) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.addCourse(CourseModel.fromEntity(course));
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(int id) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.deleteCourse(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateCourse(Course course) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.updateCourse(CourseModel.fromEntity(course));
    });
  }

  @override
  Future<Either<Failure, List<CourseItem>>> getCourseItems(int courseId) async{
    return await safeExecuteTaskWithNetworkCheck<List<CourseItem>>(networkInfo,() async{
      var response= await remoteDataSource.getCourseItems(courseId);

      return  response.map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addCourseItem(CourseItem CourseItem) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.addCourseItem(CourseItemModel.fromEntity(CourseItem));
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteCourseItem(int id) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.deleteCourseItem(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateCourseItem(CourseItem CourseItem) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.updateCourseItem(CourseItemModel.fromEntity(CourseItem));
    });
  }




}
