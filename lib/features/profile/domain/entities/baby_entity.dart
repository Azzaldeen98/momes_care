import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:moms_care/core/constants/enam/gender.dart';

class Baby extends Equatable {

 final int? id;
 final String? urlImage;
 final String? name;
 final int? age;
 final double? height;
 final double? weight;
 final String? numberOfResponsibleDoctor;
 final Gender? gender;
 final DateTime? birthDay;

  Baby({
     this.id,
     this.urlImage = "",
     this.name,
     this.age,
     this.height,
     this.weight,
     this.numberOfResponsibleDoctor,
     this.gender,
     this.birthDay,
  });

 Baby  copyWith({
    int? id,
    String? name,
    String? urlImage,
    double? height,
    double? weight,
    String? numResponseDoctor,
    Gender? gender,
    DateTime?  birthDay
})=> Baby(
    id: id ?? this.id ,
    urlImage: urlImage ?? this.urlImage,
    name: name ?? this.name,
    numberOfResponsibleDoctor: numResponseDoctor ?? this.numberOfResponsibleDoctor,
    gender:  gender ?? this.gender,
    birthDay: birthDay ?? this.birthDay,
    height: height ?? this.height,
    weight: weight ?? this.weight
  );

 @override
 List<Object?> get props => [
  id,
  urlImage,
  name,
  age,
  height,
  weight,
  numberOfResponsibleDoctor,
  gender,
  birthDay];

}




