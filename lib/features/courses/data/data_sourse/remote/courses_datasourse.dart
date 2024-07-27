import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/remote/api_service.dart';
import 'package:moms_care/core/remote/firebase/firebase_storage_actions.dart';
import 'package:moms_care/core/server/header_server.dart';
import 'package:moms_care/features/courses/data/models/course_media_model.dart';
import 'package:moms_care/features/courses/data/models/course_model.dart';
import 'package:moms_care/features/courses/domain/entities/course_media.dart';

import '../../../../../core/data/models/base_response.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getAllCourses();
  Future<List<CourseMediaModel>> getCourseMedias(int courseId);
  Future<String> uploadFile(File file);
  Future<Unit> addCourse(CourseModel course);
  Future<Unit>  updateCourse(CourseModel course);
  Future<Unit>  deleteCourse(int id);

  Future<Unit> addCourseItem(CourseMediaModel courseMedia);
  Future<Unit> updateCourseItem(CourseMediaModel courseMedia);
  Future<Unit> deleteCourseItem(int id);

}

class CourseRemoteDataSourceImpl extends CourseRemoteDataSource {

  String? baseUrl;
  final RemoteDioService? remoteDioService ;
  CourseRemoteDataSourceImpl({this.remoteDioService,this.baseUrl}){
    baseUrl ??= BASE_URL;
    baseUrl='${baseUrl}api/v1/Course';
  }
  @override
  Future<List<CourseModel>> getAllCourses() async {
    final json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getAll'),);
    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
      print("jsonMap: ${response.result.toString()}");
      List<CourseModel> courses = (response.result as List).map((item) => CourseModel.fromJson(item)).toList();
      return courses;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<String> uploadFile(File file) async{

   return  await FirebaseStorageActions.uploadFile(file:file ,folder:STORAGE_COURSES_ID);

  }

  @override
  Future<Unit> addCourse(CourseModel course) async{

    print(jsonEncode(course.toCreateJson()));
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.post('${baseUrl}/create',
            data: jsonEncode(course.toCreateJson())
        ),);
    return _getUnitResponseMessage(json);
  }

  @override
  Future<Unit> deleteCourse(int id) async{
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.delete('${baseUrl}/delete?id=${id}',));
    return _getUnitResponseMessage(json);
  }

  @override
  Future<Unit> updateCourse(CourseModel course)async{

    print("updateCourse::: ${jsonEncode(course.toJson())}");
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.put('${baseUrl}/update',
        data: jsonEncode(course.toJson())));
    return _getUnitResponseMessage(json);
  }

  Unit _getUnitResponseMessage(dynamic json){

    print("UpdateResponse: $json");
    var response = BaseResponse.fromJson(json!);
    // print("UpdateResponse: ${response.result}");
    if(response !=null && response.isSuccess){
      return unit;
    } else
      throw ServerExecption();
  }

  @override
  Future<List<CourseMediaModel>> getCourseMedias(int courseId) async{


    final json = await remoteDioService?.executeWithToken((dio) => dio.get('${baseUrl}/getCourseMedias?courseId=${courseId}'),);
    var response = BaseResponse.fromJson(json!);
    if(response !=null && response.isSuccess){
      print("jsonMap: ${response.result.toString()}");
      List<CourseMediaModel> courses = (response.result as List).map((item) => CourseMediaModel.fromJson(item)).toList();
      return courses;
    }
    else
      throw ServerExecption();
  }

  @override
  Future<Unit> addCourseItem(CourseMediaModel courseMedia) async{

    print(jsonEncode(courseMedia.toCreateJson()));
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.post('${baseUrl}/createCourseMedia',
            data: jsonEncode(courseMedia.toCreateJson())));
    return _getUnitResponseMessage(json);
  }

  @override
  Future<Unit> deleteCourseItem(int id) async{
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.delete('${baseUrl}/deleteCourseMedia?id=${id}',));
    return _getUnitResponseMessage(json);
  }

  @override
  Future<Unit> updateCourseItem(CourseMediaModel courseMedia) async{
    final json = await remoteDioService?.executeWithToken((dio) =>
        dio.put('${baseUrl}/updateCourseMedia',
            data: jsonEncode(courseMedia.toJson())));
    return _getUnitResponseMessage(json);
  }
}


