
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import '../../error/exception.dart';
import '../../error/faiture.dart';


 Future<Either<Failure,T>> safeExecuteTaskWithNetworkCheck<T>(NetworkInfo networkInfo,
     Future<T> Function()  callback,{  Function()?  onNotConnected}) async{

  if(await networkInfo.isConnected){
    try{

      if(T == Unit || T is Unit){
        await callback();
        print("safeExecuteTaskWithNetworkCheck : Unit");
        return Right(unit as T);
      }else{
        final response = await callback();
        print("safeExecuteTaskWithNetworkCheck : Response");
        return Right(response);
      }
    }
    on ServerExecption{ return Left(ServerFailure());}
    on InvalidEmailOrPasswordExecption{return Left(InvalidEmailOrPasswordFailure());}
    on AccountNotActiveExecption{return Left(AccountNotActiveFailure());}
    on OldPasswordExecption{return Left(OldPasswordFailure());}
    on SigOutExecption{return Left(SigOutFailure());}
    on CustomerExistisExecption{return Left(CustomerExistisFailure());}
    on CustomerNotFoundExecption {return Left(CustomerNotFoundFailure());}
    on FirebaseException{return Left(FirebaseFailure());}
    on OfflineExecption{return Left(OfflineFailure());}
    on EmptyCacheException{return Left(EmptyCacheFailure());}
    on AuthorizeException{return Left(AuthorizeFailure());}
    on AuthenticationException{return Left(AuthenticationFailure());}
    on Exception{return Left(ErrorFailure());}

  }else{
    if(onNotConnected!=null) {
      final response = await onNotConnected();
      return Right(response);
    }
    return Left(OfflineFailure());
  }

}