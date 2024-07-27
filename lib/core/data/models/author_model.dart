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
  factory  AuthorModel.fromEntity(Author? auth)=> AuthorModel(
    id: auth!.id ?? "",
    image: auth!.image  ?? "",
    name: auth!.name ?? "",
  );


  Map<String, dynamic>  toJson({AuthorModel? model})=> <String, dynamic>{
      "id": model!.id ?? id ?? "" ,
      "name": model!.name ?? image ?? "",
      "image":model!.image  ??  name ??""
  };

}
