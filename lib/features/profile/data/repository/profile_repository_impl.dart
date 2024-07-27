

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/constants/enam/app_refresh_data.dart';
import 'package:moms_care/core/error/exception.dart';

import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/core/utils/function/set_remove_auth.dart';
import 'package:moms_care/features/auth/persention/page/auth_view.dart';
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


  Future<ProfileModel> _getProfileInfoFromApi() async{
    final profileModel= await  remoteDataSource.getInfo();
    if(profileModel!=null){
      CacheHelper.setString(PROFILE_INFO_CACHED, jsonEncode(profileModel!.toJson()??""));
    }
    return  profileModel;
  }


  @override
  Future<Either<Failure, Profile>> refreshProfileInfo() async{
    return await safeExecuteTaskWithNetworkCheck<Profile>(networkInfo,() async{
      return  await  _getProfileInfoFromApi();
    });
  }

  @override
  Future<Either<Failure, Profile>> getProfileInfo() async{
    return await safeExecuteTaskWithNetworkCheck<Profile>(networkInfo,() async{
      try {
            var profile = CacheHelper.getString(PROFILE_INFO_CACHED);
            if (profile != null  && profile.isNotEmpty) {
              return ProfileModel.fromJson(jsonDecode(profile));
            } else {
              return  await  _getProfileInfoFromApi();
            }
      }catch(e){
        throw Exception(e);
      }
    },
    onNotConnected: () {
    var profile = CacheHelper.getString(PROFILE_INFO_CACHED);
    if (profile != null  && profile.isNotEmpty) {
      return  ProfileModel.fromJson(jsonDecode(profile));
    }
    });

  }

  @override
  Future<Either<Failure, List<Post>>> getMyPosts() async{
    return await safeExecuteTaskWithNetworkCheck<List<Post>>(networkInfo,() async{
      return (await  remoteDataSource.getMyPosts()).map((item)=> item.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> updateEmail(String pass,String email) async{

    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
    try{

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: pass,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updateEmail(email);
        print("تم تحديث البريد الإلكتروني بنجاح!");
        return await  remoteDataSource.updateEmail(email);
      }else{
            removeAuth();
            Get.offAll(const AuthView());
            throw AuthenticationException();
      }


      // var user = FirebaseAuth.instance.currentUser;
      // if(user!=null){
      //
      //   removeAuth();
      //   Get.offAll(const AuthView());
      //   exit(1);
      // }
      //
      // await user?.updateEmail(email);

    } on FirebaseException catch (e){
      throw FirebaseException(plugin: e.plugin);
    } on ServerException catch(e){
      throw ServerException(e.toString());
    }

    });
  }

  @override
  Future<Either<Failure, Unit>> updateName(String name) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
     return  await  remoteDataSource.updateName(name);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(String currentPass, String newPass) async{
    return await safeExecuteTaskWithNetworkCheck<Unit>(networkInfo,() async{
      try{
        var auth=FirebaseAuth.instance.currentUser;
        if(auth!=null){
          await  auth?.updatePassword(newPass);
          return await  remoteDataSource.changePassword(currentPassword: currentPass, newPassword: newPass);
        }else{
          throw FirebaseException(plugin:"user is null!");
        }

      } on FirebaseException catch (e){
        throw FirebaseException(plugin: e.plugin);
      } on Exception catch(e){
        throw ServerException(e.toString());
      }


    });
  }

  @override
  Future<Either<Failure, String>> uploadImage(File image,String? oldUrl) async{

    return await safeExecuteTaskWithNetworkCheck<String>(networkInfo,() async {
      var urlImage= await  remoteDataSource.uploadImageToStorage(image,oldUrl);
      if(urlImage!=null && urlImage.isNotEmpty){
           await  remoteDataSource.updateImage(urlImage);
        return urlImage;
      }
      return "";
    });
  }



}