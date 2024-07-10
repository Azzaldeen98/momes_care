import 'package:dartz/dartz.dart';
import '../../../../core/error/faiture.dart';
import '../repositories/speech_repozitorese.dart';

class AskAiUseCases {

  AskAiUseCases(this.reostitory);

  final SpeechRepository reostitory;

  //call من اجل نستعدي الدالة باسم الكلاس
  Future<Either<Failure,String>> call(String text) async {
    return await reostitory.askAI(text);
  }
}
