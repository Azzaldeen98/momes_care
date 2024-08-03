



import 'package:moms_care/core/data/models/author_model.dart';
import '../../domain/entities/Post.dart';
import 'comment_model.dart';






class PostModel extends Post{

  // final AuthorModel? author;

  PostModel({
    super.id,
    super.title,
    super.body,
    super.publishedAt,
    super.likes,
    super.comments,
    super.commentsCount,
    super.userLiked,
    super.author
  });

  factory PostModel.fromJson(Map<String, dynamic> _json) => PostModel(
    id: _json['id'] ,
    title: _json['title'] as String?,
    body: _json['body'] as String?,
    publishedAt: _json['publishedAt'] != null
        ? DateTime.parse(_json['publishedAt'] as String)
        : null,
    likes: _json['likes'] ,
    userLiked: _json['userLiked'] ,
    commentsCount: _json['commentsCount'],
    comments:(_json['comments']==null)?[]
        :(_json['comments'] as List<dynamic>).map((comment) =>
        CommentModel.fromJson(comment!)).toList(),

    author: (_json['author']==null) ?null: AuthorModel.fromJson(_json['author'])

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
      author: this.author,
      userLiked: this.userLiked,
    );



}
