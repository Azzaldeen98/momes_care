

import 'package:equatable/equatable.dart';

import '../../../../core/data/entities/author.dart';
import 'Post.dart';


class Comment extends Equatable{

  final int? id;
  final String? contant;
  final DateTime ? createdAt;
  final int? likes;
  final Author? author;
  final bool? userLiked;
  final Post? post;

  Comment({this.id, this.contant, this.createdAt, this.likes,this.author,this.userLiked,this.post});

  @override
  List<Object?> get props => [id,contant,createdAt,likes,author,userLiked,post];

  Comment copyWith({
    int? id,
    String? contant,
    bool?userLiked,
    Author? author,
    Post? post,
    int? likes}) {
        return Comment(
          id: id ?? this.id ?? 0 ,
          contant: contant ?? this.contant ?? "",
          createdAt:  this.createdAt ?? DateTime.now(),
          author: author ?? this.author ,
          post: post ?? this.post ,
          userLiked: userLiked ?? this.userLiked ,
          likes: likes ?? this.likes ,
        );
  }

}