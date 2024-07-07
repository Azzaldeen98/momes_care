

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/Post.dart';

@JsonSerializable()
class PostModel extends Post{

  PostModel({
    super.id,
    super.title,
    super.body,
    super.publishedAt,
    super.likes});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'] ,
    title: json['title'] as String?,
    body: json['body'] as String?,
    publishedAt: json['publishedAt'] != null
        ? DateTime.parse(json['publishedAt'] as String)
        : null,
    likes: json['likes'] as int,
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
      id: post.id,
      title: post.title,
      body: post.body,
      publishedAt: post.publishedAt,
      likes: post.likes,
    );
  }
  Post toEntity() => Post(
      id: this.id,
      title: this.title ?? '',
      body: this.body ?? '',
      publishedAt: this.publishedAt ?? DateTime.now(),
      likes: this.likes,
    );



}
