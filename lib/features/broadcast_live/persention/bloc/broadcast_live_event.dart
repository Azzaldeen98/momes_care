
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';

abstract class BroadcastLiveEvent extends Equatable {
  const BroadcastLiveEvent();
  @override
  List<Object> get props => [];
}

class GetBroadcastLiveEvent extends BroadcastLiveEvent{
   const GetBroadcastLiveEvent();
 }
class RefreshMyBroadcastLivesEvent extends BroadcastLiveEvent{
   const RefreshMyBroadcastLivesEvent();
 }
class GetMyBroadcastLivesEvent extends BroadcastLiveEvent{
  const GetMyBroadcastLivesEvent();
}

class GetActivesBroadcastLivesEvent extends BroadcastLiveEvent{
  const GetActivesBroadcastLivesEvent();
}
class GetAllBroadcastLiveJoinsEvent extends BroadcastLiveEvent{
  final int broadcastLiveId;
  const GetAllBroadcastLiveJoinsEvent({required this.broadcastLiveId});
}
class UpdateBroadcastLiveEvent extends BroadcastLiveEvent{
  final BroadcastLive broadcastLive;
  const UpdateBroadcastLiveEvent({required this.broadcastLive});
}
class AddBroadcastLiveEvent extends BroadcastLiveEvent{
  final BroadcastLive broadcastLive;
  const AddBroadcastLiveEvent({required this.broadcastLive});
}

// class AddBroadcastLiveJoinEvent extends BroadcastLiveEvent{
//   final BroadcastLive broadcastLiveJoin;
//   const AddBroadcastLiveJoinEvent({required this.BroadcastLiveJoin});
// }
//
// class UpdateBroadcastLiveJoinEvent extends BroadcastLiveEvent{
//   final BroadcastLiveJoin BroadcastLiveJoin;
//   const UpdateBroadcastLiveJoinEvent({required this.BroadcastLiveJoin});
// }

class StopBroadcastLiveEvent extends BroadcastLiveEvent{
  final int id;
  const StopBroadcastLiveEvent({required this.id});
}
class DeleteBroadcastLiveEvent extends BroadcastLiveEvent{
  final int id;
  const DeleteBroadcastLiveEvent({required this.id});
}








