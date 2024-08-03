

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';

class DailyCareTimes extends Equatable{
  final int? id;
  final String time;
  final String descript;
  final bool state;
  final CareType? careType;
  final AgeGroup? ageGroup;
  final int? careTypeId;
  final int? ageGroupId;
  const DailyCareTimes({
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
}