


import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_media.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
  @override
  List<Object> get props => [];
}
class GetCourseEvent extends CourseEvent{
   const GetCourseEvent();
 }
 class RefreshCoursesEvent extends CourseEvent{
   const RefreshCoursesEvent();
 }

class GetAllCoursesEvent extends CourseEvent{
  const GetAllCoursesEvent();
}

class GetAllCourseItemsEvent extends CourseEvent{
  final int courseId;
  const GetAllCourseItemsEvent({required this.courseId});
}

class UpdateCourseEvent extends CourseEvent{
  final Course course;
  const UpdateCourseEvent({required this.course});
}

class UploadCourseFileEvent extends CourseEvent{
  final File file;
  final String? oldUrl;
  const UploadCourseFileEvent({required this.file,this.oldUrl});
}

class AddCourseEvent extends CourseEvent{
  final Course course;
  const AddCourseEvent({required this.course});
}
class AddCourseItemEvent extends CourseEvent{
  final CourseMedia courseItem;
  const AddCourseItemEvent({required this.courseItem});
}

class UpdateCourseItemEvent extends CourseEvent{
  final CourseMedia courseItem;
  const UpdateCourseItemEvent({required this.courseItem});
}
class DeleteCourseItemEvent extends CourseEvent{
  final int id;
  final String? UrlMedia;
  const DeleteCourseItemEvent({required this.id,this.UrlMedia});
}

class DeleteCourseEvent extends CourseEvent{
  final int id;
  final String? oldUrlMedia;
  const DeleteCourseEvent({required this.id,this.oldUrlMedia});
}


class UploadCourseImageEvent extends CourseEvent{
  final String oldUrl;
  final File image;
  const UploadCourseImageEvent({required this.image, this.oldUrl=""});
}


// class GoToCoursePageEvent extends CourseEvent{
//   final CoursePage page;
//   const GoToCoursePageEvent({required this.page,});
// }






