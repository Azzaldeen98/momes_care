import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/constants/enam/media_type.dart';
import 'package:moms_care/features/courses/data/models/course_model.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';

class CourseItemModel extends CourseItem{
  final CourseModel? course;
  CourseItemModel({
    super.id,
    required super.title,
    super.descript,
    super.url,
    super.mediaType,
    this.course,
  });

  factory CourseItemModel.fromJson(Map<String, dynamic> json) {
    return CourseItemModel(
      id: json['id'],
      title: json['title'],
      descript: json['descript'],
      url: json['url'],
      mediaType: MediaTypes.values[json['mediaType']],
      course: json['course'] != null ? CourseModel.fromJson(json['course']) : null,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'title': title,
      'descript': descript,
      'courseId': (course!=null)? course!.id : 0,
        'url': url,
      'mediaType': mediaType!.index
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'descript': descript,
      'url': url,
      'mediaType': mediaType!.index,
    };
  }



  factory CourseItemModel.fromEntity(CourseItem entity) {
    return CourseItemModel(
      id: entity.id,
      title: entity.title,
      descript: entity.descript,
      url: entity.url,
      mediaType: entity.mediaType,
      course: entity.course != null ? CourseModel.fromEntity(entity.course!) : null,
    );
  }

  CourseItem toEntity() {
    return CourseItem(
      id: id,
      title: title,
      descript: descript ?? '',
      url: url ?? '',
      mediaType: mediaType,
      course: course?.toEntity(), // تأكد من أن لديك دالة toEntity في CourseModel
    );
  }

}



