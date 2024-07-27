import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/forum/domain/entities/Comment.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

class CommentsController extends GetxController {
  var post = Rx<Post?>(null);




  // طريقة لتحديث بيانات التعليق
  void updatePost(Post newPost) {
    post.value = newPost;
    post.refresh();
  }

}
