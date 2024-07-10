

import 'package:json_annotation/json_annotation.dart';
import 'package:moms_care/core/data/models/author_model.dart';
import 'package:moms_care/features/forum/domain/entities/Comment.dart';
import 'package:moms_care/features/moms_care/presentation/bloc/local/speech/commands.dart';

import '../../domain/entities/Post.dart';


@JsonSerializable()
class CommentModel extends Comment{
  // final AuthorModel? author;

  CommentModel({
    super.id,
    super.contant,
    super.createdAt,
    super.likes,
    super  .author});

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
  factory CommentModel.fromEntity(Comment comment) {
    return comment as CommentModel;
  }


}
