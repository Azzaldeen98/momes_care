

import 'package:equatable/equatable.dart';

class Post extends Equatable{

  final int? id;
  final String? title;
  final String? body;
  final DateTime ? publishedAt;
  final int? likes;

  Post({ this.id, this.title,  this.body, this.publishedAt,this.likes=0});

  @override
  List<Object?> get props => [
    id,
    title,
    body,
    publishedAt,
    likes
  ];

}