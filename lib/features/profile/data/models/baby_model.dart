

import 'package:moms_care/core/constants/enam/gender.dart';
import 'package:moms_care/core/data/view_models/date_time_view_model.dart';
import '../../domain/entities/baby_entity.dart';


class BabyModel extends Baby {

  BabyModel({
    super.id,
    super.urlImage = "",
    super.name,
    super.age,
    super.height,
    super.weight,
    super.numberOfResponsibleDoctor,
    super.gender,
    super.birthDay,
  });

  // fromJson
  factory BabyModel.fromJson(Map<String, dynamic> json) {
    return BabyModel(
      id: json['id'],
      urlImage: json['urlImage'],// == null? null : json['urlImage'] ,
      name: json['name'] ,
      age: json['age'] ,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      numberOfResponsibleDoctor: json['numberOfResponsibleDoctor'],
      gender: Gender.values[json['gender']],
      birthDay:json['birthDay'] == null? null
          : DateTime.parse(json['birthDay'] as String),
    );
  }
  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'urlImage': urlImage,
      'name': name,
      'height': height,
      'weight': weight,
      'age': age,
      'numberOfResponsibleDoctor': numberOfResponsibleDoctor,
      'gender': gender!.index,
      'birthDay': birthDay?.toIso8601String(),
    };
  }

  Map<String, dynamic> getJsonCreateBaby() {
    return {
      'Name': name,
      'Height': height,
      'Weight': weight,
      'NumberOfResponsibleDoctor': numberOfResponsibleDoctor,
      'Gender': gender!.index,
      'urlImage': urlImage??"",
      'BirthDay': birthDay!.toIso8601String(),// "${DateTimeViewModel(dateTime:this.birthDay!).date}"??"",
    };
  }
  // fromEntity
  factory BabyModel.fromEntity(Baby entity) {
    return BabyModel(
      id: entity.id,
      urlImage: entity.urlImage ?? "",
      name: entity.name,
      height: entity.height,
      weight: entity.weight,
      numberOfResponsibleDoctor: entity.numberOfResponsibleDoctor,
      gender: entity.gender,
      birthDay: entity.birthDay,
    );
  }
  // toEntity
  Baby toEntity() {
    return Baby(
      id: id,
      urlImage: urlImage,
      name: name,
      age: age,
      height: height,
      weight: weight,
      numberOfResponsibleDoctor: numberOfResponsibleDoctor,
      gender: gender,
      birthDay: birthDay,
    );
  }

}