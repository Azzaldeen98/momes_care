

import 'package:equatable/equatable.dart';


class Comment extends Equatable{

  final int? id;
  final String? contant;
  final DateTime ? createdAt;
  final int? likes;

  Comment({this.id, this.contant, this.createdAt, this.likes});

  @override

  List<Object?> get props => [id,contant,createdAt,likes];

}