import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:moms_care/core/constants/data.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/daily_care_times_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/data/models/daily_care_times_model.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/domain/repositories/daily_care_times_repozitorese.dart';



class DailyCareTimesRepositoryImpl extends DailyCareTimesRepository {

  DailyCareTimesRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  final DailyCareTimesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Unit>> create(DailyCareTimes entity) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return  await remoteDataSource.create(DailyCareTimesModel.fromEntity(entity));
    });
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return  await remoteDataSource.delete(id);
    });
  }

  @override
  Future<Either<Failure, List<DailyCareTimes>>> getAll() async{
    return await safeExecuteTaskWithNetworkCheck<List<DailyCareTimes>>(networkInfo,() async{
      var response= await remoteDataSource.getAll();
      return  response.map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> update(DailyCareTimes entity) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
     return  await remoteDataSource.update(DailyCareTimesModel.fromEntity(entity));
    });
  }

  @override
  Future<Either<Failure, List<DailyCareTimes>>> getBabyDailyCareTimes(int babyId) async{
    return await safeExecuteTaskWithNetworkCheck<List<DailyCareTimes>>(networkInfo,() async{
      var response = await remoteDataSource.getBabyDailyCareTimes(babyId);
      return  response.map((item)=> item.toEntity()).toList();
    });
  }


}
