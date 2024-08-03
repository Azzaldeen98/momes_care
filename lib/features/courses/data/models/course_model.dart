

import 'package:equatable/equatable.dart';
import 'package:moms_care/core/constants/enam/course_types.dart';
import 'package:moms_care/core/constants/enam/media_type.dart';
import 'package:moms_care/features/courses/data/models/course_item_model.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';




class CourseModel extends Course{

  final List<CourseItemModel>? CourseItems;

 const CourseModel({
   super.id,
    super.title,
    super.descript,
    super.type,
    super.urlImage,
   this.CourseItems,
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
      CourseItems: json['CourseItems'] ==null ? []
          :(json['CourseItems'] as List).map((mediaJson) => CourseItemModel.fromJson(mediaJson)).toList(),
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
      // 'CourseItems': CourseItems!.map((media) => media.toJson()).toList(),
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
      CourseItems:entity.CourseItems==null ? []
          : entity.CourseItems!.map((e) => CourseItemModel.fromEntity(e)).toList(),
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
      CourseItems:(CourseItems==null)? [] : CourseItems!.map((mediaModel) => mediaModel.toEntity()).toList(),
    );
  }

}

