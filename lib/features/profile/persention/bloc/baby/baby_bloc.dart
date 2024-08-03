

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moms_care/core/constants/messages.dart';

import 'package:moms_care/features/profile/domain/usecases/baby/add_baby_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/baby/delete_baby_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/baby/get_baby_daily_care_times_use_case.dart';
import 'package:moms_care/features/profile/domain/usecases/baby/update_baby_use_case.dart';

import 'package:moms_care/features/profile/persention/bloc/baby/baby_event.dart';
import 'package:moms_care/features/profile/persention/bloc/baby/baby_state.dart';


import 'package:moms_care/core/error/message_failure_message.dart';


class BabyBloc extends Bloc<BabyEvent,BabyState>{


  final AddBabyUseCase  addBabyUseCase;
  final UpdateBabyUseCase updateBabyUseCase;
  final DeleteBabyUseCase deleteBabyUseCase;
  final GetBabyDailyCareTimesUseCase getBabyDailyCareTimesUseCase;

  BabyBloc({
    required this.addBabyUseCase,
    required this.updateBabyUseCase,
    required this.deleteBabyUseCase,
    required this.getBabyDailyCareTimesUseCase,
    }):super(const BabyInitialState()){

    on<GetBabyDailyCareTimesEvent>(_getBabyDailyCareTimes);
    on<AddBabyEvent>(_addBaby);
    on<UpdateBabyEvent>(_updateBaby);
    on<DeleteBabyEvent>(_deleteBaby);

  }



  FutureOr<void> _addBaby(AddBabyEvent event, Emitter<BabyState> emit) async {
    emit(const LoadingBabiesState());
    final failureOrSuccess=await addBabyUseCase(event.baby);
    failureOrSuccess.fold(
            (failure)=> emit(ErrorBabyState(message: mapFailureToMessage(failure))),
        (_)=>emit(AddUpdateDeleteBabySuccessState(message: ADD_SUCCESS_MESSAGE)));
      // (failure)=> ErrorBabyState(message: mapFailureToMessage(failure)),
      // (_)=> AddUpdateDeleteBabySuccessState(message: ADD_SUCCESS_MESSAGE));
  }

  FutureOr<void> _updateBaby(UpdateBabyEvent event, Emitter<BabyState> emit) async {
    emit(const LoadingBabiesState());
    final failureOrSuccess=await updateBabyUseCase(event.baby);
    failureOrSuccess.fold(
        (failure)=>emit(ErrorBabyState(message: mapFailureToMessage(failure))),
        (info)=>emit(AddUpdateDeleteBabySuccessState(message: UPDATE_SUCCESS_MESSAGE)));
  }

  FutureOr<void> _deleteBaby(DeleteBabyEvent event, Emitter<BabyState> emit) async{
    emit(const LoadingBabiesState());
    final failureOrSuccess=await deleteBabyUseCase(event.id);
    failureOrSuccess.fold(
            (failure){
          emit(ErrorBabyState(message: mapFailureToMessage(failure)));
        }, (info){
          emit(AddUpdateDeleteBabySuccessState(message: DELETE_SUCCESS_MESSAGE));
        });
  }

  FutureOr<void> _getBabyDailyCareTimes(GetBabyDailyCareTimesEvent event,
      Emitter<BabyState> emit)async {
    emit(const LoadingBabyDailyCareTimesState());
    final failureOrItems=await getBabyDailyCareTimesUseCase(event.babyId);
    failureOrItems.fold(
            (failure){
          emit(ErrorBabyState(message: mapFailureToMessage(failure)));
        }, (items){
      emit(LoadedBabyDailyCareTimesState(dailyCareTimes: items));
    });
  }
}

