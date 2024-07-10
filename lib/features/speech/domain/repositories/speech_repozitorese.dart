import 'package:dartz/dartz.dart';
import '../../../../core/error/faiture.dart';

abstract class SpeechRepository {
  Future<Either<Failure,String>> askAI(String text);
}
