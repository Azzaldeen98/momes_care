
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/auth/data/models/signup_model.dart';

import '../../../domain/entities/auth.dart';
import '../../../domain/entities/user_info.dart' as local;
import '../../../domain/repositories/firebase/firebase_auth_repo.dart';
import '../../dataSourse/remote/firebase_auth_api_service.dart';

typedef Future<Auth> ExecuteAuthMethods();

 class FirebaseAuthRepositoryImp implements FirebaseAuthRepository {

   final NetworkInfo networkInfo;
   final FirebaseAuthApiService remoteDataSource;

  const FirebaseAuthRepositoryImp({required this.networkInfo,required this.remoteDataSource});



   Future<Either<Failure,Auth>> _execute(ExecuteAuthMethods executeAuthMethods) async{
     if(await networkInfo.isConnected){
       try{
         final response = await executeAuthMethods();
         return Right(response);
       } on ServerExecption{
         return Left(ServerFailure());
       }on InvalidEmailOrPasswordExecption{
         return Left(InvalidEmailOrPasswordFailure());
       } on CustomerExistisExecption{
         return Left(CustomerExistisFailure());
       } on FirebaseException{
         return Left(WrongDataFailure());
       }on AccountNotActiveExecption {
         return Left(AccountNotActiveFailure());
       }
     }else{
       return Left(OfflineFailure());
     }

   }

  @override
  Future<Either<Failure, Auth>> signIn({required String email, required String password}) async {
      return await _execute(() async{
        final response= await  remoteDataSource.signIn({"email":email, "password":password,});
        printError(info: response.userInfo!.toJson().toString());
        return response;
      });
  }

  @override
  Future<Either<Failure, Auth>> signUp({required String email, required String password}) async {
    return await _execute(() async{
      final response= await  remoteDataSource.signUp({ "email": email, "password": password});
      return response;
    });
  }



}
