
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';




abstract class CourseState extends Equatable {
  const CourseState();
  @override
  List<Object> get props => [];
}
class CourseInitialState extends CourseState{
  const CourseInitialState();
}
class LoadingCourseState extends CourseState{
  const LoadingCourseState();
}
class LoadingCourseUpdateState extends CourseState{
  const LoadingCourseUpdateState();
}

class LoadingUploadFileState extends CourseState{
  const LoadingUploadFileState();
}

class UploadImageSuccessfulState extends CourseState{
  final String downloadURL;
  const UploadImageSuccessfulState({required this.downloadURL});
}

class UploadFileSuccessfulState extends CourseState{
  final String downloadURL;
  const UploadFileSuccessfulState({required this.downloadURL});
}

class UpdateCourseSuccessfulState extends CourseState {
  const UpdateCourseSuccessfulState({required this.course});
  final Course course;
}

// class GoToCoursePageState extends CourseState{
//   const GoToCoursePageState( {required this.page});
//   // final CoursePage page;
//   // @override
//   // List<Object> get props => [page];
// }
class LoadedCoursesState extends CourseState{
  const LoadedCoursesState( {required this.courses});
  final List<Course> courses;
  @override
  List<Object> get props => [courses];
}
class LoadedCourseItemsState extends CourseState{
  const LoadedCourseItemsState({required this.courseItems});
  final List<CourseItem> courseItems;
  @override
  List<Object> get props => [courseItems];
}

class UpdateCourseUserInfoSuccessState extends CourseState{
  const UpdateCourseUserInfoSuccessState( {required this.message,this.requiredSignOut=false});
  final String message;
  final bool requiredSignOut;
  @override
  List<Object> get props => [message];
}
class AddUpdateDeleteCourseSuccessState extends CourseState{
  const AddUpdateDeleteCourseSuccessState( {required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
class ErrorUpdateCourseState extends CourseState {
  final String message;
  const ErrorUpdateCourseState({required this.message});
  @override
  List<Object> get props => [message];
}


class ErrorCourseState extends CourseState {
  final String message;
  const ErrorCourseState({required this.message});
  @override
  List<Object> get props => [message];
}


