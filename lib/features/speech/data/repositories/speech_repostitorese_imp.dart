import 'package:dartz/dartz.dart';
import '../../../../core/controller/work_on_servers/remote_task.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/faiture.dart';
import '../../../../core/controller/work_on_servers/network/network_info.dart';
import '../../domain/repositories/speech_repozitorese.dart';
import '../dataSourse/remote/speech_remote_datasourse.dart';


class SpeechRepositoryImpl extends SpeechRepository {

  SpeechRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  final SpeechRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, String>> askAI(String text)async {
    return await safeExecuteTaskWithNetworkCheck<String>(networkInfo,() async{
      return await remoteDataSource.askAi(text);
    });
  }
}
