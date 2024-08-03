


import 'package:moms_care/core/constants/enam/broadcast_live_status.dart';
import 'package:moms_care/features/broadcast_live/data/models/user_view_model.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/user_view.dart';




class BroadcastLiveModel extends BroadcastLive{


 const BroadcastLiveModel({
     super.id,
     super.descript,
     super.link,
     super.status,
     super.startDateTime,
     super.createdAt,
     super.user,
  });

  // fromJson method
  factory BroadcastLiveModel.fromJson(Map<String, dynamic> json) {
    return BroadcastLiveModel(
      id: json['id'],
      descript: json['descript'],
      link: json['link'],
      status: BroadcastLiveStatus.values[json['status']],
      startDateTime: json['startDateTime']==null? null: DateTime.parse(json['startDateTime']),
      createdAt: json['createdAt']==null? null : DateTime.parse(json['createdAt']),
      user: json['user']==null? null : UserViewModel.fromJson(json['user']),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'descript': descript,
      'status': status!.index,
      'link': link,
      'startDateTime': startDateTime!.toIso8601String(),
    };
  }

  // fromEntity method
  factory BroadcastLiveModel.fromEntity(BroadcastLive entity) {
    return BroadcastLiveModel(
      id: entity.id,
      descript: entity.descript,
      link: entity.link,
      status: entity.status,
      startDateTime: entity.startDateTime,
      createdAt: entity.createdAt ,
    );
  }

  // toEntity method
  BroadcastLive toEntity() {
    return BroadcastLive(
      id: id,
      descript: descript,
      link: link,
      status: status,
      startDateTime: startDateTime,
      createdAt: createdAt,
      user: user,
    );
  }

  // copyWith method
  BroadcastLiveModel copyWith({
    int? id,
    String? descript,
    String? link,
    BroadcastLiveStatus? status,
    DateTime? startDateTime,
    DateTime? createdAt,
    UserView? user,
  }) {
    return BroadcastLiveModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      descript: descript ?? this.descript,
      link: link ?? this.link,
      status: status ?? this.status,
      startDateTime: startDateTime ?? this.startDateTime,
      user: user ?? this.user,
    );
  }
}



