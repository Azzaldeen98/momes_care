
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_moms_care_items_usecase.dart';

part 'moms_care_event.dart';
part 'moms_care_state.dart';

class MomsCareBloc extends Bloc<MomsCareEvent, MomsCareState> {

  final GetMomsCareItemsUseCase getMomsCareItemsUseCase;

  MomsCareBloc({required this.getMomsCareItemsUseCase}) : super(MomsCareInitial()) {
    on<GetMomsCareItemsEvent>((e,s){
      emit(GetMomsCareItemsSuccessfulState(items: List<String>.empty()));
    });
    // on<GetMomsCareItemsEvent>(_GetMomsCareItemsEvent);
  }

  // Future<void> _searchitemsEvent(
  //     SearchitemsEvent event, Emitter<MomsCareState> emit) async {
  //   emit(LoadingGetMomsCareItemsState());
  //   final failureOrGetAllData = await GetMomsCareItemsUsecases(event.partId);
  //   emit(failureOrGetAllData.fold(
  //       (failuer) =>
  //           ErrorGetMomsCareItemsState(message: mapFailureToMessage(failuer)),
  //       (items) => GetMomsCareItemsSeccessfulState(items: items)));
  // }
  //
  // Future<void> _GetMomsCareItemsEvent(
  //     GetMomsCareItemsEvent event, Emitter<MomsCareState> emit) async {
  //   emit(LoadingGetMomsCareItemsState());
  //   try {
  //     final resonse = await http.get(
  //         Uri.parse("${BASE_URL}api/items/getAllGeneral?skip=1&take=30"),
  //         headers: HeaderServer.headerWithToken);
  //     if (resonse.statusCode == 200 || resonse.statusCode == 201) {
  //       final decodeJson = json.decode(resonse.body);
  //       var items = (decodeJson as List<dynamic>?)
  //               ?.map((e) => items.fromJson(e as Map<String, dynamic>))
  //               .toList() ?? [];
  //       emit(GetMomsCareItemsSeccessfulState(items: List<items>.empty()));
  //     } else {
  //       emit(const ErrorGetMomsCareItemsState(message: ""));
  //     }
  //   } catch (e) {
  //     emit(const ErrorGetMomsCareItemsState(message: ""));
  //   }
  // }
}
