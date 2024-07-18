

import 'package:dartz/dartz.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/features/profile/data/dataSource/remote/babies/profile_babies_remote_data_source.dart';
import 'package:moms_care/features/profile/data/models/baby_model.dart';

import 'package:moms_care/features/profile/data/models/profile_model.dart';

import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import 'package:moms_care/features/profile/domain/entities/baby_entity.dart';
import 'package:moms_care/features/profile/domain/repository/profile_babies_repository.dart';
import '../../domain/repository/profile_repository.dart';
import '../dataSource/remote/profile_remote_data_source.dart';

class BabiesRepositoryImpl  implements   BabiesRepository{

  final BabiesRemoteDataSource remoteDataSource;
  final NetworkInfo  networkInfo;

  BabiesRepositoryImpl({required this.remoteDataSource,required this.networkInfo});


  @override
  Future<Either<Failure, Unit>> createBaby(Baby baby) async {


    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.create(BabyModel.fromEntity(baby));
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteBaby(int id) async {
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.delete(id);
    });
  }

  @override
  Future<Either<Failure, List<Baby>>> getAllBabies() async{
    return await safeExecuteTaskWithNetworkCheck<List<Baby>>(networkInfo,() async{
      return (await  remoteDataSource.getAll()).map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Baby>> getBaby(int id) async{
    return await safeExecuteTaskWithNetworkCheck<Baby>(networkInfo,() async{
      return (await remoteDataSource.getOne(id)).toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> updateBaby(Baby baby) async {
    print("updateBabyRepository....");
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await remoteDataSource.update(BabyModel.fromEntity(baby));
    });
  }

}