import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/features/broadcast_live/data/data_sourse/remote/broadcast_live_datasourse.dart';
import 'package:moms_care/features/broadcast_live/data/models/broadcast_live_model.dart';
import 'package:moms_care/features/broadcast_live/domain/entities/broadcast_live.dart';
import '../../domain/repositories/broadcast_live_repository.dart';


class BroadcastLivesRepositoryImpl extends BroadcastLivesRepository {

  BroadcastLivesRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  final BroadcastLiveRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<BroadcastLive>>> getMyBroadcastLives() async{
    return await safeExecuteTaskWithNetworkCheck<List<BroadcastLive>>(networkInfo,() async{
      var response= await remoteDataSource.getMyBroadcastLives();
      return  response.map((item)=> item.toEntity()).toList();
    });
  }
  @override
  Future<Either<Failure, List<BroadcastLive>>> getActiveBroadcastLives() async{
    return await safeExecuteTaskWithNetworkCheck<List<BroadcastLive>>(networkInfo,() async{
      var response= await remoteDataSource.getActivesBroadcastLives();
      return  response.map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addBroadcastLive(BroadcastLive broadcastLive) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.addBroadcastLive(BroadcastLiveModel.fromEntity(broadcastLive));
    });
  }

  @override
  Future<Either<Failure, Unit>> updateBroadcastLive(BroadcastLive broadcastLive) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.updateBroadcastLive(BroadcastLiveModel.fromEntity(broadcastLive));
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteBroadcastLive(int id) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.deleteBroadcastLive(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> stopBroadcastLive(int id) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.stopBroadcastLive(id);
    });
  }








}
