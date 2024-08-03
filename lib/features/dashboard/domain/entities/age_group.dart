

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:moms_care/core/constants/enam/time_period_scale.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';

//  classes
class AgeGroup extends Equatable{
  final int? id;
  final int min;
  final int max;
  final TimePeriodScale timePeriodScale;
  final List<DailyCareTimes>? dailyCareTimes;

  const AgeGroup({
     this.id,
    required this.min,
    required this.max,
    required this.timePeriodScale,
     this.dailyCareTimes,
  });

  @override
  List<Object?> get props => [id,min,max,timePeriodScale,dailyCareTimes];
}



