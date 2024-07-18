

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/speech/domain/repositories/speech_repozitorese.dart';

class AskGeminiAiUseCase {
  final SpeechRepository reostitory;

  const AskGeminiAiUseCase(this.reostitory);

  Future<Either<Failure,String>> call(String text) async {
    return await reostitory.askAI(text);
  }
}