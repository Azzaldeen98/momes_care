

import 'package:equatable/equatable.dart';
import 'package:moms_care/core/constants/enam/course_types.dart';
import 'package:moms_care/core/constants/enam/media_type.dart';
import 'package:moms_care/features/courses/data/models/course_media_model.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_media.dart';




class CourseModel extends Course{

  final List<CourseMediaModel>? courseMedias;

 const CourseModel({
   super.id,
    super.title,
    super.descript,
    super.type,
    super.urlImage,
   this.courseMedias,
   super.createdAt});





  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'] as String,
      descript: json['descript'] as String,
      type:(json['type']!=null && CourseType.isValid(json['type']))?
      CourseType.fromString(json['type']!) : CourseType.firstValue() ,
      urlImage: json['urlImage'] as String,
      createdAt: json['createdAt']!=null ? DateTime.parse(json['createdAt']):DateTime.now(),
      courseMedias: json['courseMedias'] ==null ? []
          :(json['courseMedias'] as List).map((mediaJson) => CourseMediaModel.fromJson(mediaJson)).toList(),
    );
  }

  // تحويل كائن Course إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'descript': descript,
      'type': CourseType.isValid(type!.text) ? type!.text! : CourseType.firstValue()!.text ,
      'urlImage': urlImage,
      // 'createdAt': createdAt!.toIso8601String(),
      // 'courseMedias': courseMedias!.map((media) => media.toJson()).toList(),
    };
  }
  Map<String, dynamic> toCreateJson() {
    return {
      'title': title,
      'descript': descript,
      'type': CourseType.isValid(type!.text) ? type!.text! : CourseType.firstValue()!.text ,
      'urlImage': urlImage,
    };
  }

  factory CourseModel.fromEntity(Course entity) {
    return CourseModel(
      id: entity.id,
      title: entity.title,
      descript: entity.descript,
      type: entity.type,
      urlImage: entity.urlImage,
      createdAt: entity.createdAt,
      courseMedias:entity.courseMedias==null ? []
          : entity.courseMedias!.map((e) => CourseMediaModel.fromEntity(e)).toList(),
    );
  }

  Course toEntity() {
    return Course(
      id: id,
      title: title,
      descript: descript,
      type: type,
      urlImage: urlImage,
      createdAt: createdAt,
      courseMedias:(courseMedias==null)? [] : courseMedias!.map((mediaModel) => mediaModel.toEntity()).toList(),
    );
  }

}

