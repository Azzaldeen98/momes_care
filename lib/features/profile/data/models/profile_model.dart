

import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/baby_entity.dart';
import 'baby_model.dart';

// Assuming you have already defined BabyIndex class
class Profile  extends Equatable{
  
  String? displayName;
  String? email;
  String? image;
  int? posts;
  int? likesReceived;
  int? likesGiven;
  int? comments;
  List<Baby>? babies;

  Profile({
     this.displayName,
     this.email,
     this.image="",
     this.posts=0,
     this.likesReceived=0,
     this.likesGiven=0,
     this.comments=0,
     this.babies,
  });


  @override
  List<Object?> get props =>
      [
        displayName,
        email,
        image,
        posts,
        likesReceived,
        likesGiven,
        comments,
        babies,
      ];
}

class ProfileModel extends Profile {

 final  List<BabyModel>? babies;

  ProfileModel({
         super.displayName,
         super.email,
         super.image,
         super.posts,
         super.likesReceived,
         super.likesGiven,
         super.comments,
         this.babies }):super(babies:babies);

  // fromJson
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      displayName: json['displayName'],
      email: json['email'] as String,
      image: json['image'] == null? null : json['image']  as String ??"",
      posts: json['posts'],
      likesReceived: json['likesReceived'],
      likesGiven: json['likesGiven'],
      comments: json['comments'],
      babies:(json['babies']==null)?[]: (json['babies'] as  List<dynamic>)
          .map((baby) => BabyModel.fromJson(baby))
          .toList(),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'image': image,
      'posts': posts,
      'likesReceived': likesReceived,
      'likesGiven': likesGiven,
      'comments': comments,
       'babies': babies!.map((baby) => baby!.toJson()).toList(),
    };
  }


  factory ProfileModel.fromEntity(Profile entity) {
    return ProfileModel(
      displayName: entity.displayName,
      email: entity.email,
      image: entity.image,
      posts: entity.posts,
      likesReceived: entity.likesReceived,
      likesGiven: entity.likesGiven,
      comments: entity.comments,
      babies: entity.babies!.map((baby) => BabyModel.fromEntity(baby)).toList(),
    );
  }


  Profile toEntity() {
    return Profile(
      displayName: displayName,
      email: email,
      image: image,
      posts: posts,
      likesReceived: likesReceived,
      likesGiven: likesGiven,
      comments: comments,
      babies:(babies!=null)?  babies!.map((baby) => baby.toEntity()).toList()
      : null,
    );
  }
}

// Assuming you have already defined BabyIndex class and its corresponding entity class
// class ProfileEntity {
//   String displayName;
//   String email;
//   String image;
//   int posts;
//   int likesReceived;
//   int likesGiven;
//   int comments;
//   List<BabyIndexEntity> babies;
//
//   ProfileEntity({
//      this.displayName,
//      this.email,
//      this.image,
//      this.posts,
//      this.likesReceived,
//      this.likesGiven,
//      this.comments,
//      this.babies,
//   });
// }
//
// // Assuming you have already defined BabyIndex and BabyIndexEntity classes
// class BabyIndex {
//   int id;
//   String image;
//   String name;
//   double height;
//   double weight;
//   String numberOfResponsibleDoctor;
//   Gender gender;
//   DateTime birthDay;
//
//   BabyIndex({
//      this.id,
//     this.image = "",
//      this.name,
//      this.height,
//      this.weight,
//      this.numberOfResponsibleDoctor,
//      this.gender,
//      this.birthDay,
//   });
//
//   factory BabyIndex.fromJson(Map<String, dynamic> json) {
//     return BabyIndex(
//       id: json['id'],
//       image: json['image'] ?? "",
//       name: json['name'],
//       height: json['height'],
//       weight: json['weight'],
//       numberOfResponsibleDoctor: json['numberOfResponsibleDoctor'],
//       gender: Gender.values[json['gender']],
//       birthDay: DateTime.parse(json['birthDay']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'image': image,
//       'name': name,
//       'height': height,
//       'weight': weight,
//       'numberOfResponsibleDoctor': numberOfResponsibleDoctor,
//       'gender': gender.index,
//       'birthDay': birthDay.toIso8601String(),
//     };
//   }
//
//   factory BabyIndex.fromEntity(BabyIndexEntity entity) {
//     return BabyIndex(
//       id: entity.id,
//       image: entity.image ?? "",
//       name: entity.name,
//       height: entity.height,
//       weight: entity.weight,
//       numberOfResponsibleDoctor: entity.numberOfResponsibleDoctor,
//       gender: entity.gender,
//       birthDay: entity.birthDay,
//     );
//   }
//
//   BabyIndexEntity toEntity() {
//     return BabyIndexEntity(
//       id: id,
//       image: image,
//       name: name,
//       height: height,
//       weight: weight,
//       numberOfResponsibleDoctor: numberOfResponsibleDoctor,
//       gender: gender,
//       birthDay: birthDay,
//     );
//   }
// }
//
// enum Gender { male, female }
//
// class BabyIndexEntity {
//   int id;
//   String? image;
//   String name;
//   double height;
//   double weight;
//   String numberOfResponsibleDoctor;
//   Gender gender;
//   DateTime birthDay;
//
//   BabyIndexEntity({
//      this.id,
//      this.image,
//      this.name,
//      this.height,
//      this.weight,
//      this.numberOfResponsibleDoctor,
//      this.gender,
//      this.birthDay,
//   });
// }
