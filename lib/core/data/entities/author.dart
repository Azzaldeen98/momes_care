

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


class Author extends Equatable{

  final String? id;
  final String? name;
  final String? image;

  Author({
     this.id,
     this.name,
     this.image});

  @override
  List<Object?> get props => [
    id,
    name,
    image
  ];

}


//Commentator