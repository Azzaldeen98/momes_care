import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/faiture.dart';
import '../../../../core/controller/work_on_servers/network/network_info.dart';
import '../../domain/repositories/sps_repostitorese.dart';
import '../data_sourse/sps_datasourse.dart';

class FleetkeyRepostitoryImp extends FleetkeyRepostitory {
  final SPSRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  FleetkeyRepostitoryImp(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<SparePart>>> getAllData(String partId) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllData(partId);
        return Right(remotePosts);
      } on ServerExecption {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
