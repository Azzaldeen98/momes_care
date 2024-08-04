
import 'dart:developer';
import 'dart:typed_data';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:moms_care/core/constants/enam/user_roles.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/core/error/exception.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/auth/data/models/signup_model.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../../domain/entities/auth.dart';
import '../../../domain/entities/user_info.dart' as local;
import '../../../domain/repositories/firebase/firebase_auth_repo.dart';
import '../auth_remote_data_source.dart';
import 'auth_api_service.dart';
//
abstract class FirebaseAuthApiService     {
  Future<Auth> signIn(@Body() Map<String, dynamic> model);
  Future<Auth> signUp(@Body() Map<String, dynamic> model );
}

class FirebaseAuthApiServiceImp implements FirebaseAuthApiService {

  final FirebaseAuth _firebaseAuth;
  FirebaseAuthApiServiceImp({FirebaseAuth? firebaseAuth}) :_firebaseAuth=firebaseAuth ?? FirebaseAuth.instance;
  @override
  Future<Auth> signIn(Map<String, dynamic> model) async{
    try{
      UserCredential user_credit=await _firebaseAuth.signInWithEmailAndPassword(email: model['email'], password: model['password']);
      final user=Auth(userInfo:local.UserInfo(
          uId: user_credit.user?.uid,
          name: user_credit.user?.displayName,
          email:user_credit.user?.email,
          token:await user_credit.user!.getIdToken()??""));
        return user;
    } on FirebaseException{
      rethrow;
    }
  }
  @override
  Future<Auth> signUp(Map<String, dynamic> model) async {
    try{
      UserCredential user_credit= await _firebaseAuth.createUserWithEmailAndPassword(
          email:model['email']! ,
          password:model['password']!);
      print("UserCredential");

      if(user_credit==null)  throw CustomerExistisExecption();

      final user=Auth(userInfo:local.UserInfo(
          uId: user_credit.user?.uid,
          email:user_credit.user?.email));
      return user;

    } on FirebaseException{
      print("UserCredential-E1");
      throw CustomerExistisExecption();
    }on ServerExecption{
      throw ServerExecption();
    }catch(e){
      print("UserCredential-E2");
      throw CustomerExistisExecption();
    }
  }
}

