

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moms_care/core/error/message_failure_message.dart';
import 'package:moms_care/features/speech/domain/usecases/ask_gemini_ai_use_case.dart';
import 'package:moms_care/features/speech/persention/bloc/gemini/gemini_event.dart';
import 'package:moms_care/features/speech/persention/bloc/gemini/gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent,GeminiState>{

  AskGeminiAiUseCase askGeminiAiUseCase;
  GeminiBloc({
    required this.askGeminiAiUseCase
  }):super(GeminiInitial()){
    on<AskGeminiEvent>(_askGemini);
  }


  FutureOr<void> _askGemini(AskGeminiEvent event, Emitter<GeminiState> emit)async {

    print("inputText : ${event.inputText}");

    emit(const LoadingGeminiState());

    final failureOrResult=await askGeminiAiUseCase(event.inputText);
    failureOrResult.fold(
        (failure)=>emit(ErrorGeminiState(message: mapFailureToMessage(failure))),
        (result){
          print("GeminiBloc-Result : ${result}");
          emit(LoadedGeminiState(ressult: result));
        });
  }
}