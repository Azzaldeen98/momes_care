import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../entities/author.dart';



class PostCommentViewModel extends Author{

  PostCommentViewModel({
    super.id,
    super.name,
    super.image});

}
