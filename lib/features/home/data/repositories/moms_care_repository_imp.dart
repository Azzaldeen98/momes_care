import 'package:dartz/dartz.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import '../../domain/repositories/moms_care_repository.dart';

import '../data_sourse/moms_care_datasourse.dart';

class MomsCareRepositoryImpl extends MomsCareRepository {

  MomsCareRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  final MomsCareRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<String>>>  getItems() async {
    return await safeExecuteTaskWithNetworkCheck<List<String>>(networkInfo,() async{
      return await remoteDataSource.getItems();
    });
  }




}
