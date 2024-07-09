

import 'package:json_annotation/json_annotation.dart';
import 'package:moms_care/features/forum/domain/entities/Comment.dart';
import 'package:moms_care/features/moms_care/presentation/bloc/local/speech/commands.dart';

import '../../domain/entities/Post.dart';
import 'comment_model.dart';

@JsonSerializable()



@JsonSerializable()
class PostModel extends Post{

  PostModel({
    super.id,
    super.title,
    super.body,
    super.publishedAt,
    super.likes,
    super.comments,
    super.commentsCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'] ,
    title: json['title'] as String?,
    body: json['body'] as String?,
    publishedAt: json['publishedAt'] != null
        ? DateTime.parse(json['publishedAt'] as String)
        : null,
    likes: json['likes'] ,
    commentsCount: json['commentsCount'],
    comments:(json['comments']==null)?[]
        :(json['comments'] as List<dynamic>).map((comment) =>
        CommentModel.fromJson(comment!)).toList(),
  );



  Map<String, dynamic> toJson() =><String, dynamic>{
  'id': this.id.toString(),
  'title': this.title,
  'body': this.body,
  'publishedAt':  this.publishedAt?.toIso8601String(),
  'likes': this.likes,
  };
  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id ?? 0,
      title: post.title ?? "",
      body: post.body ?? "",
      publishedAt: post.publishedAt ?? DateTime.now(),
      likes: post.likes ?? 0,
    );
  }

  Post toEntity() => Post(
      id: this.id,
      title: this.title ?? '',
      body: this.body ?? '',
      publishedAt: this.publishedAt ?? DateTime.now(),
      likes: this.likes,
      commentsCount: this.commentsCount,
      comments: this.comments,
    );



}
