import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/constants/enam/media_type.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';

class CourseMedia extends Equatable{
  final int? id;
  final String title;
  final String? descript;
  final String? url;
  final MediaTypes? mediaType;
  final Course? course;

  CourseMedia({
     this.id,
    required this.title,
    this.descript,
    this.url,
     this.mediaType,
    this.course,
  });
  @override
  List<Object?> get props => [
    id,
    title,
    descript,
    url,
    mediaType,
    course,];

  CourseMedia copyWith({
    int? id,
    String? title,
    String? descript,
    MediaTypes ? mediaType,
    String? url,
  Course? course}) {
    return CourseMedia(
      id: id ?? this.id ?? null,
      title: title ?? this.title ?? "",
      descript: descript ?? this.descript ?? "",
      url: url ?? this.url ?? "",
      mediaType: mediaType ?? this.mediaType ?? null,);
      course: course ?? this.course ?? null;
  }


}



