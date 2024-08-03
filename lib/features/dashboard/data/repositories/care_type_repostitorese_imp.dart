import 'package:dartz/dartz.dart';
import 'package:moms_care/core/constants/data.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/care_type_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/daily_care_times_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/data/models/care_type_model.dart';
import 'package:moms_care/features/dashboard/data/models/daily_care_times_model.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/domain/repositories/care_type_repozitorese.dart';
import 'package:moms_care/features/dashboard/domain/repositories/daily_care_times_repozitorese.dart';



class CareTypeRepositoryImpl extends CareTypeRepository {

  CareTypeRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  final CareTypeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Unit>> create(CareType entity) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return  await remoteDataSource.create(CareTypeModel.fromEntity(entity));
    });
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return  await remoteDataSource.delete(id);
    });
  }

  @override
  Future<Either<Failure, List<CareType>>> getAll() async{
    return await safeExecuteTaskWithNetworkCheck<List<CareType>>(networkInfo,() async{
      var response= await remoteDataSource.getAll();
      return  response.map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> update(CareType entity) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
     return  await remoteDataSource.update(CareTypeModel.fromEntity(entity));
    });
  }

  @override
  Future<Either<Failure, List<CareType>>> getAllWithCareType() async{
    return await safeExecuteTaskWithNetworkCheck<List<CareType>>(networkInfo,() async{
      var response= await remoteDataSource.getAllWithDailyCareTimes();
      return  response.map((item)=> item.toEntity()).toList();
    });
  }


}
