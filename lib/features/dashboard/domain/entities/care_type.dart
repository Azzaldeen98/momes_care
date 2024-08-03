




import 'package:equatable/equatable.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';

class CareType extends Equatable{
  final int? id;
  final String name;
  final bool state;
  final List<DailyCareTimes>? dailyCareTimes;

  const CareType({
     this.id,
    required this.name,
    required this.state,
     this.dailyCareTimes,
  });

  @override
  List<Object?> get props => [id,name,state,dailyCareTimes];
}