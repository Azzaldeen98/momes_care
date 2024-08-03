

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:moms_care/core/constants/enam/time_period_scale.dart';
import 'package:moms_care/features/dashboard/data/models/daily_care_times_model.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';

// Model classes
class AgeGroupModel extends Equatable{
  final int? id;
  final int min;
  final int max;
  final TimePeriodScale timePeriodScale;
  final List<DailyCareTimesModel>? dailyCareTimes;

 const AgeGroupModel({
     this.id,
    required this.min,
    required this.max,
    required this.timePeriodScale,
     this.dailyCareTimes,
  });

  @override
  List<Object?> get props => [id,min,max,timePeriodScale,dailyCareTimes];

  // JSON serialization
  factory AgeGroupModel.fromJson(Map<String, dynamic> json) {
    return AgeGroupModel(
      id: json['id'],
      min: json['min'],
      max: json['max'],
      timePeriodScale: TimePeriodScale.values[json['timePeriodScale']],
      dailyCareTimes:json['dailyCareTimes']==null ?[]: (json['dailyCareTimes'] as List)
          .map((i) => DailyCareTimesModel.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'min': min,
      'max': max,
      'timePeriodScale': timePeriodScale.index,
    };
  }
  Map<String, dynamic> toCreateJson() {
    return {
      'min': min,
      'max': max,
      'timePeriodScale': timePeriodScale.index,
    };
  }

  // Entity conversion
  AgeGroup toEntity() {
    return AgeGroup(
      id: id,
      min: min,
      max: max,
      timePeriodScale: timePeriodScale,
      dailyCareTimes:(dailyCareTimes==null)?[] : dailyCareTimes?.map((e) => e.toEntity()).toList(),
    );
  }

  factory AgeGroupModel.fromEntity(AgeGroup entity) {
    return AgeGroupModel(
      id: entity.id,
      min: entity.min,
      max: entity.max,
      timePeriodScale: entity.timePeriodScale,
      dailyCareTimes: ( entity.dailyCareTimes==null)?[] : entity.dailyCareTimes?.map((e) => DailyCareTimesModel.fromEntity(e)).toList(),
    );
  }

  // Copy method
  AgeGroupModel copyWith({
    int? id,
    int? min,
    int? max,
    TimePeriodScale? timePeriodScale,
    List<DailyCareTimesModel>? dailyCareTimes,
  }) {
    return AgeGroupModel(
      id: id ?? this.id,
      min: min ?? this.min,
      max: max ?? this.max,
      timePeriodScale: timePeriodScale ?? this.timePeriodScale,
      dailyCareTimes: dailyCareTimes ?? this.dailyCareTimes,
    );
  }
}




