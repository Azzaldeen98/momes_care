

import 'package:dartz/dartz.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';

import 'package:moms_care/features/profile/data/models/profile_model.dart';

import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import '../../domain/repository/profile_repository.dart';
import '../dataSource/remote/profile_remote_data_source.dart';

class ProfileRepositoryImpl  implements   ProfileRepository{


  ProfileRepositoryImpl({required this.remoteDataSource,required this.networkInfo});


  final ProfileRemoteDataSource  remoteDataSource;
  final NetworkInfo  networkInfo;

  @override
  Future<Either<Failure, Profile>> getProfileInfo() async{
    return await safeExecuteTaskWithNetworkCheck<Profile>(networkInfo,() async{
      final response= await  remoteDataSource.getInfo();
      return  response; //!.toEntity();
    });

  }

  @override
  Future<Either<Failure, List<Post>>> getMyPosts() async{
    return await safeExecuteTaskWithNetworkCheck<List<Post>>(networkInfo,() async{
      return (await  remoteDataSource.getMyPosts()).map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> updateEmail(String email) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await  remoteDataSource.updateEmail(email);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateName(String name) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await  remoteDataSource.updateName(name);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(String currentPass, String newPass) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      return await  remoteDataSource.updatePassword(
          currentPassword: currentPass, newPassword: newPass);
    });
  }

}