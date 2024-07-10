

import 'package:equatable/equatable.dart';

import '../../../../core/data/entities/author.dart';


class Comment extends Equatable{

  final int? id;
  final String? contant;
  final DateTime ? createdAt;
  final int? likes;
  final Author? author;

  Comment({this.id, this.contant, this.createdAt, this.likes,this.author});

  @override

  List<Object?> get props => [id,contant,createdAt,likes,author];

}