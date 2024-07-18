

import 'package:json_annotation/json_annotation.dart';
import 'package:moms_care/core/data/models/author_model.dart';
import 'package:moms_care/features/forum/domain/entities/Comment.dart';

import '../../domain/entities/Post.dart';


@JsonSerializable()
class CommentModel extends Comment{
  // final AuthorModel? author;

  CommentModel({
    super.id,
    super.contant,
    super.createdAt,
    super.likes,
    super.postId,
    super.author});

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'] ,
    contant: json['contant'] as String?,
    createdAt:  json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : null,
    likes: json['likes'] ?? 0 ,
    author:  (json['author']==null) ? null : AuthorModel.fromJson(json['author']) ,
  );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': this.id.toString() ?? "",
    'contant': this.contant ?? "",
    'createdAt': this.createdAt ?? "",
    'likes': this.likes.toString() ?? "",
  };
  Comment toEntity() => Comment(
    id: this.id ?? 0,
    contant: this.contant ?? "",
    createdAt: this.createdAt ?? DateTime.now(),
    likes: this.likes ?? 0,
    author: this.author,
    userLiked: this.userLiked
  );


  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: comment.id ?? 0,
      contant: comment.contant ?? "",
      createdAt: comment.createdAt ?? DateTime.now(),
      likes: comment.likes ?? 0,
      postId: comment.postId ??0,
    );
  }





}
