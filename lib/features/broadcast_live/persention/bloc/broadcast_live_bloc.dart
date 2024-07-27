

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/core/remote/firebase/firebase_storage_actions.dart';

import 'package:moms_care/features/broadcast_live/domain/UseCases/get_my_broadcast_live_UseCase.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/add_broadcast_live_usecase.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/delete_broadcast_live_use_case.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/get_active_broadcast_live_usecase.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/update_broadcast_live_usecase.dart';
import 'package:moms_care/features/broadcast_live/domain/usecases/stop_broadcast_live_use_case.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_event.dart';
import 'package:moms_care/features/broadcast_live/persention/bloc/broadcast_live_state.dart';


class BroadcastLiveBloc extends Bloc<BroadcastLiveEvent,BroadcastLiveState>{

  final GetMyBroadcastLiveUseCase  getMyBroadcastLiveUseCase ;
  final GetActivesBroadcastLiveUseCase  getActivesBroadcastLiveUseCase ;
  final AddBroadcastLiveUseCase addBroadcastLiveUseCase ;
  final UpdateBroadcastLiveUseCase updateBroadcastLiveUseCase ;
  final DeleteBroadcastLiveUseCase  deleteBroadcastLiveUseCase ;
  final StopBroadcastLiveUseCase   stopBroadcastLiveUseCase;

  BroadcastLiveBloc({
    required this.getMyBroadcastLiveUseCase,
    required this.getActivesBroadcastLiveUseCase,
    required this.addBroadcastLiveUseCase,
    required this.updateBroadcastLiveUseCase,
    required this.deleteBroadcastLiveUseCase,
    required this.stopBroadcastLiveUseCase,
    }):super(const BroadcastLiveInitialState()){

    on<GetMyBroadcastLivesEvent>(_getAllBroadcastLives);
    on<GetActivesBroadcastLivesEvent>(_getActivesBroadcastLive);
    on<AddBroadcastLiveEvent>(_addBroadcastLives);
    on<UpdateBroadcastLiveEvent>(_updateBroadcastLives);
    on<DeleteBroadcastLiveEvent>(_deleteBroadcastLives);
    on<StopBroadcastLiveEvent>(_stopBroadcastLives);


  }
  FutureOr<void> _getAllBroadcastLives(GetMyBroadcastLivesEvent event, Emitter<BroadcastLiveState> emit) async{
    emit(const LoadingBroadcastLiveState());
    var failureOrDownloadURL=await getMyBroadcastLiveUseCase();
    failureOrDownloadURL.fold(
            (failure){
          emit(ErrorBroadcastLiveState(message: mapFailureToMessage(failure)));
        }, (items){
      emit(LoadedBroadcastLivesState(broadcastLives: items));
    });
  }
  FutureOr<void> _getActivesBroadcastLive(GetActivesBroadcastLivesEvent event, Emitter<BroadcastLiveState> emit) async{
    emit(const LoadingBroadcastLiveState());
    var failureOrDownloadURL=await getActivesBroadcastLiveUseCase();
    failureOrDownloadURL.fold(
            (failure){
          emit(ErrorBroadcastLiveState(message: mapFailureToMessage(failure)));
        }, (items){
      emit(LoadedBroadcastLivesState(broadcastLives: items));
    });
  }
  FutureOr<void> _addBroadcastLives(AddBroadcastLiveEvent event, Emitter<BroadcastLiveState> emit) async{
    emit(const LoadingBroadcastLiveState());
    var failureOrSuccess=await addBroadcastLiveUseCase(event.broadcastLive);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorBroadcastLiveState(message: mapFailureToMessage(failure)));
        }, (_){
      emit(AddUpdateDeleteBroadcastLiveSuccessState(message: ADD_SUCCESS_MESSAGE));
    });
  }
  FutureOr<void> _updateBroadcastLives(UpdateBroadcastLiveEvent event, Emitter<BroadcastLiveState> emit) async{
    emit(const LoadingBroadcastLiveState());
    var failureOrSuccess=await updateBroadcastLiveUseCase(event.broadcastLive);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorBroadcastLiveState(message: mapFailureToMessage(failure)));
        }, (_){
      emit(AddUpdateDeleteBroadcastLiveSuccessState(message: UPDATE_SUCCESS_MESSAGE));
    });
  }
  FutureOr<void> _deleteBroadcastLives(DeleteBroadcastLiveEvent event, Emitter<BroadcastLiveState> emit) async{
    emit(const LoadingBroadcastLiveState());
    try {
      var failureOrSuccess = await deleteBroadcastLiveUseCase(event.id);
      failureOrSuccess.fold(
              (failure) {
            emit(ErrorBroadcastLiveState(message: mapFailureToMessage(failure)));
          }, (_) {
        emit(
            AddUpdateDeleteBroadcastLiveSuccessState(message: DELETE_SUCCESS_MESSAGE));
      });
    }catch(e){
      Get.back();
    }

  }
  FutureOr<void> _stopBroadcastLives(StopBroadcastLiveEvent event, Emitter<BroadcastLiveState> emit) async{
    emit(const LoadingBroadcastLiveState());
    try {
      var failureOrSuccess = await stopBroadcastLiveUseCase(event.id);
      failureOrSuccess.fold(
              (failure) {
            emit(ErrorBroadcastLiveState(message: mapFailureToMessage(failure)));
          }, (_) {
        emit(const StopBroadcastLiveSuccessState());});
    }catch(e){
      Get.back();
    }

  }

}

