

import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'package:moms_care/features/forum/domain/entities/Comment.dart';

import '../../../../core/data/entities/author.dart';


class Post extends Equatable{

  final int? id;
  final String? title;
  final String? body;
  final DateTime ? publishedAt;
  final int? likes;
  final int? commentsCount;
  final List<Comment>? comments;
  final Author? author;
  final bool? userLiked;

  Post({ this.id,
    this.title,
    this.body,
    this.publishedAt,
    this.commentsCount,
    this.likes=0,
    this.comments=null,
    this.userLiked,
    this.author});

  @override
  List<Object?> get props => [
    id,
    title,
    body,
    publishedAt,
    likes,
    comments,
    userLiked,
    commentsCount,
    author
  ];

  Post copyWith({int? id,String? title,String? body}) {
    return Post(
      id: id ?? this.id ?? 0,
      title: title ??  this.title ?? "",
      body: body ?? this.body ?? "",
      publishedAt: this.publishedAt ?? DateTime.now(),
    );
  }

}

