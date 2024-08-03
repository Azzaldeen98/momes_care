

import 'package:equatable/equatable.dart';
import 'package:moms_care/core/constants/enam/broadcast_live_status.dart';
import 'package:moms_care/core/constants/enam/course_types.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';
import 'package:moms_care/features/broadcast_live/data/models/broadcast_live_model.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/user_view.dart';


class BroadcastLive  extends Equatable{
  final int? id;
  final String? descript;
  final String? link;
  final BroadcastLiveStatus? status;
  final DateTime? startDateTime;
  final DateTime? createdAt;
  final UserView?  user;

  const BroadcastLive({
     this.id,
     this.descript,
     this.link,
     this.status,
     this.startDateTime,
     this.createdAt,
     this.user,
  });

  // copyWith method
  BroadcastLive copyWith({
    int? id,
    String? descript,
    BroadcastLiveStatus? status,
    DateTime? startDateTime,
    DateTime? createdAt,
  }) {
    return BroadcastLive(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      descript: descript ?? this.descript,
      status: status ?? this.status,
      startDateTime: startDateTime ?? this.startDateTime,
    );
  }

  @override
  List<Object?> get props => [id,descript,link,status,startDateTime,user];
}







