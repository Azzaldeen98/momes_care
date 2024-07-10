import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../entities/author.dart';


@JsonSerializable()
class AuthorModel extends Author{

  AuthorModel({
    super.id,
    super.name,
    super.image});


  factory AuthorModel.fromJson(Map<String, dynamic> json)=> AuthorModel(
    id: json['id'] as String ?? " " ,
    name: json['name'] as String ?? " ",
    image:json['image'] as String ?? " "
  );

  Map<String, dynamic>  toJson(AuthorModel model)=> <String, dynamic>{
      "id": model.id ?? "" ,
      "name": model.name ?? "",
      "image":model.image  ?? ""
  };

}
