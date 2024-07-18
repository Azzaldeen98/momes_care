import 'package:dartz/dartz.dart';
import 'package:moms_care/core/constants/data.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import '../../domain/repositories/speech_repozitorese.dart';
import '../dataSourse/remote/speech_remote_datasourse.dart';


class SpeechRepositoryImpl extends SpeechRepository {

  SpeechRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  final SpeechRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, String>> askAI(String text)async {
    var res= await safeExecuteTaskWithNetworkCheck<String>(networkInfo,() async{
      return await remoteDataSource.askAi(text);
    });
    print("SpeechRepository-Result : ${res}");
    return res;
  }
}
