import 'package:equatable/equatable.dart';
import 'package:moms_care/features/dashboard/data/models/daily_care_times_model.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';

class CareTypeModel extends Equatable{
  final int? id;
  final String name;
  final bool state;
  final List<DailyCareTimesModel>? dailyCareTimes;

  CareTypeModel({
     this.id,
    required this.name,
    required this.state,
     this.dailyCareTimes,
  });

  @override
  List<Object?> get props => [id,name,state,dailyCareTimes];
  // JSON serialization
  factory CareTypeModel.fromJson(Map<String, dynamic> json) {
    return CareTypeModel(
      id: json['id'],
      name: json['name'],
      state: json['state'],
      dailyCareTimes: json['dailyCareTimes']==null?[]: (json['dailyCareTimes'] as List)
          .map((i) => DailyCareTimesModel.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'dailyCareTimes': dailyCareTimes==null?[]: dailyCareTimes?.map((e) => e.toJson()).toList(),
    };
  }
  Map<String, dynamic> toCreateJson() {
    return {
      'name': name,
      'state': state,
    };
  }
  //  conversion
  CareType toEntity() {
    return CareType(
      id: id,
      name: name,
      state: state,
      dailyCareTimes:  dailyCareTimes==null?[]: dailyCareTimes?.map((e) => e.toEntity()).toList(),
    );
  }

  factory CareTypeModel.fromEntity(CareType entity) {
    return CareTypeModel(
      id: entity.id,
      name: entity.name,
      state: entity.state,
      dailyCareTimes: entity.dailyCareTimes==null?[]: entity.dailyCareTimes?.map((e) => DailyCareTimesModel.fromEntity(e)).toList(),
    );
  }

  // Copy method
  CareTypeModel copyWith({
    int? id,
    String? name,
    bool? state,
    List<DailyCareTimesModel>? dailyCareTimes,
  }) {
    return CareTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
      dailyCareTimes: dailyCareTimes ?? this.dailyCareTimes,
    );
  }
}