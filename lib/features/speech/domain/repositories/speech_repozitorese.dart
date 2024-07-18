import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';

abstract class SpeechRepository {
  Future<Either<Failure,String>> askAI(String text);
}
