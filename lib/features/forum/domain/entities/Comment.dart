

import 'package:equatable/equatable.dart';

import '../../../../core/data/entities/author.dart';


class Comment extends Equatable{

  final int? id;
  final String? contant;
  final DateTime ? createdAt;
  final int? likes;
  final Author? author;
  final bool? userLiked;

  Comment({this.id, this.contant, this.createdAt, this.likes,this.author,this.userLiked});

  @override
  List<Object?> get props => [id,contant,createdAt,likes,author,userLiked];

  Comment copyWith({
    String? contant,
    bool?userLiked,
    Author? author,
    int? likes}) {
        return Comment(
          id:  this.id ,
          contant: contant ?? this.contant ?? "",
          createdAt:  this.createdAt ?? DateTime.now(),
          author: author ?? this.author ,
          userLiked: userLiked ?? this.userLiked ,
          likes: likes ?? this.likes ,
        );
  }

}