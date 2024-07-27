

import 'package:equatable/equatable.dart';

import 'package:moms_care/core/data/entities/author.dart';
import 'Post.dart';


class Comment extends Equatable{

  final int? id;
   final String? contant;
  final DateTime ? createdAt;
  final int? likes;
  final Author? author;
  final bool? userLiked;
  final int? postId;

  Comment({this.id, this.contant, this.createdAt, this.likes,this.author,this.userLiked,
    this.postId});

  @override
  List<Object?> get props => [id,contant,createdAt,likes,author,userLiked,postId];

  Comment copyWith({
    int? id,
    String? contant,
    bool?userLiked,
    Author? author,
    int? postId,
    int? likes}) {
        return Comment(
          id: id ?? this.id ?? 0 ,
          contant: contant ?? this.contant ?? "",
          createdAt:  this.createdAt ?? DateTime.now(),
          author: author ?? this.author ,
          postId: postId ?? this.postId ?? 0 ,
          userLiked: userLiked ?? this.userLiked ,
          likes: likes ?? this.likes ,
        );
  }

}