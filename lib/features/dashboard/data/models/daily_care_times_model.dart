


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/features/dashboard/data/models/age_group_model.dart';
import 'package:moms_care/features/dashboard/data/models/care_type_model.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';

class DailyCareTimesModel extends Equatable{
  final int? id;
  final String time;
  final String descript;
  final bool state;
  final CareTypeModel? careType;
  final AgeGroupModel? ageGroup;
  final int? careTypeId;
  final int? ageGroupId;

  const DailyCareTimesModel({
     this.id,
    this.careTypeId,
    this.ageGroupId,
    required this.time,
    required this.descript,
    required this.state,
     this.careType,
     this.ageGroup,
  });

  @override
  List<Object?> get props => [id,time,descript,state,careType,ageGroup,careTypeId,ageGroupId];

  // JSON serialization
  factory DailyCareTimesModel.fromJson(Map<String, dynamic> json) {
    return DailyCareTimesModel(
      id: json['id'],
      time: json['time'], //json['time'] != null ? Duration(json['time']) : Duration(),
      descript: json['descript'],
      state: json['state'],
      careType: json['careType']==null ? null: CareTypeModel.fromJson(json['careType']),
      ageGroup:json['ageGroup']==null ? null:  AgeGroupModel.fromJson(json['ageGroup']),
    );
  }
  Map<String, dynamic> toCraeteJson() {
    return {
      "time": time,
      "descript":descript,
      "state": state,
      "careTypeId":careTypeId,
      "ageGroupId": ageGroupId,
    };
  }


  Map<String, dynamic> toJson() {
    return {

      'id': id,
      "time": time,
      "descript":descript,
      "state": state,
      "careTypeId":careType?.id,
      "ageGroupId": ageGroup?.id,
    };
  }

  //  conversion
  DailyCareTimes toEntity() {
    return DailyCareTimes(
      id: id,
      time: time,
      descript: descript,
      state: state,
      ageGroupId:ageGroupId??0,
      careTypeId:careTypeId??0,
      careType: careType == null ? null : careType?.toEntity(),
      ageGroup: ageGroup == null ? null : ageGroup?.toEntity(),
    );
  }

  factory DailyCareTimesModel.fromEntity(DailyCareTimes entity) {
    return DailyCareTimesModel(
      id: entity.id,
      time: entity.time,
      descript: entity.descript,
      state: entity.state,
      ageGroupId:entity.ageGroupId??0,
      careTypeId:entity.careTypeId??0,
      careType: entity.careType == null ? null : CareTypeModel.fromEntity(entity.careType!),
      ageGroup: entity.ageGroup == null ? null : AgeGroupModel.fromEntity(entity.ageGroup!),
    );
  }

  // Copy method
  DailyCareTimesModel copyWith({
    int? id,
    String? time,
    String? descript,
    bool? state,
    CareTypeModel? careType,
    AgeGroupModel? ageGroup,
    final int? careTypeId,
    final int? ageGroupId,
  }) {
    return DailyCareTimesModel(
      id: id ?? this.id,
      time: time ?? this.time,
      descript: descript ?? this.descript,
      state: state ?? this.state,
      ageGroupId:ageGroupId??0,
      careTypeId:careTypeId??0,
      careType: careType ?? this.careType,
      ageGroup: ageGroup ?? this.ageGroup,
    );
  }
}