

import 'package:equatable/equatable.dart';
import 'package:moms_care/core/constants/enam/broadcast_live_status.dart';
import 'package:moms_care/core/constants/enam/course_types.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';
import 'package:moms_care/features/broadcast_live/data/models/broadcast_live_model.dart';


class UserView extends Equatable {
  String? id;
  String? email;
  String? displayName;
  String? role;
  String? urlImage;

  UserView({
     this.id,
     this.email,
     this.displayName,
     this.role,
     this.urlImage,
  });
  @override
  List<Object?> get props => [id,email,displayName,role,urlImage];
}







