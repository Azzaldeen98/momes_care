


import 'package:equatable/equatable.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';

abstract class BroadcastLiveState extends Equatable {
  const BroadcastLiveState();
  @override
  List<Object> get props => [];
}
class BroadcastLiveInitialState extends BroadcastLiveState{
  const BroadcastLiveInitialState();
}
class LoadingBroadcastLiveState extends BroadcastLiveState{
  const LoadingBroadcastLiveState();
}
class LoadingBroadcastLiveUpdateState extends BroadcastLiveState{
  const LoadingBroadcastLiveUpdateState();
}

class StopBroadcastLiveSuccessState extends BroadcastLiveState{
  const StopBroadcastLiveSuccessState();
}
class LoadedBroadcastLivesState extends BroadcastLiveState{
  const LoadedBroadcastLivesState( {required this.broadcastLives});
  final List<BroadcastLive> broadcastLives;
  @override
  List<Object> get props => [broadcastLives];
}
class LoadedBroadcastLiveJoinsState extends BroadcastLiveState{
  const LoadedBroadcastLiveJoinsState({required this.broadcastLiveJoinss});
  final List<BroadcastLive> broadcastLiveJoinss;
  @override
  List<Object> get props => [broadcastLiveJoinss];
}
class AddUpdateDeleteBroadcastLiveSuccessState extends BroadcastLiveState{
  const AddUpdateDeleteBroadcastLiveSuccessState( {required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
class ErrorBroadcastLiveState extends BroadcastLiveState {
  final String message;
  const ErrorBroadcastLiveState({required this.message});
  @override
  List<Object> get props => [message];
}


