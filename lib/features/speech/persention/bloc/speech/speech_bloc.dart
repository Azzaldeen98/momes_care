
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moms_care/features/home/domain/usecases/get_moms_care_items_usecase.dart';



part 'speech_event.dart';
part 'speech_state.dart';

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
 // final AskAiUseCases askAiUseCases; {required this.askAiUseCases}

  SpeechBloc() : super(SpeechInitial()) {
    on<SpeechEvent>((e,s){

    });
  }


}
