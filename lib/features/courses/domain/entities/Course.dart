

import 'package:equatable/equatable.dart';
import 'package:moms_care/core/constants/enam/course_types.dart';
import 'package:moms_care/features/courses/domain/entities/course_media.dart';


class Course extends Equatable{
  final int? id;
  final String? title;
  final String? descript;
  final CourseType? type;
  final String? urlImage;
  final DateTime? createdAt;
  final List<CourseMedia>? courseMedias;

 const Course({
    this.id,
    this.title,
    this.descript,
    this.type,
    this.urlImage,
    this.courseMedias,
    this.createdAt});

   Course copyWith({int? id,
                     String? title,
                     String? descript,
                     CourseType? type,
                     String? urlImage,
                     DateTime? createdAt,
   List<CourseMedia>? courseMedias})=>Course(
    id: id ?? this.id ?? null,
    title: title  ?? this.title ??"",
    descript: descript ?? this.descript ??"",
    urlImage: urlImage ?? this.urlImage ??"",
    type: type ?? this.type ?? null,
    createdAt: createdAt ?? this.createdAt ?? null,
    courseMedias:  courseMedias ?? this.courseMedias ?? [],
  );



  @override
  List<Object?> get props => [
    id,
     title,
    descript,
     type,
    urlImage,
    courseMedias,
    createdAt
  ];

}


