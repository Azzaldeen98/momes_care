import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/api_servers.dart';
import '../../../../../core/error/message_failure_message.dart';
import '../../../../../core/server/header_server.dart';
import '../../../data/data_sourse/sps_datasourse.dart';
import '../../../domain/usecases/getsparepart_usecases.dart';
import 'package:http/http.dart' as http;
part 'sps_event.dart';
part 'sps_state.dart';

class SPSBloc extends Bloc<SPSEvent, SPSState> {
  GetSparePartUsecases getSparePartUsecases;

  SPSBloc({required this.getSparePartUsecases}) : super(SPSInitial()) {
    on<SearchSparePartEvent>(_searchSparePartEvent);
    on<GetSparePartEvent>(_getSparePartEvent);
  }

  Future<void> _searchSparePartEvent(
      SearchSparePartEvent event, Emitter<SPSState> emit) async {
    emit(LoadingGetSparePartState());
    final failureOrGetAllData = await getSparePartUsecases(event.partId);
    emit(failureOrGetAllData.fold(
        (failuer) =>
            ErrorGetSparePartState(message: mapFailureToMessage(failuer)),
        (sparePart) => GetSparePartSeccessfulState(sparePart: sparePart)));
  }

  Future<void> _getSparePartEvent(
      GetSparePartEvent event, Emitter<SPSState> emit) async {
    emit(LoadingGetSparePartState());
    try {
      final resonse = await http.get(
          Uri.parse("${BASE_URL}api/SparePart/getAllGeneral?skip=1&take=30"),
          headers: HeaderServer.headerWithToken);
      if (resonse.statusCode == 200 || resonse.statusCode == 201) {
        final decodeJson = json.decode(resonse.body);
        var sparePart = (decodeJson as List<dynamic>?)
                ?.map((e) => SparePart.fromJson(e as Map<String, dynamic>))
                .toList() ?? [];
        emit(GetSparePartSeccessfulState(sparePart: List<SparePart>.empty()));
      } else {
        emit(const ErrorGetSparePartState(message: ""));
      }
    } catch (e) {
      emit(const ErrorGetSparePartState(message: ""));
    }
  }
}
