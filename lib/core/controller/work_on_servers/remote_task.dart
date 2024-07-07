
import 'package:dartz/dartz.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import '../../error/exception.dart';
import '../../error/faiture.dart';


 Future<Either<Failure,T>> safeExecuteTaskWithNetworkCheck<T>(NetworkInfo networkInfo,Future<T> Function()  callback) async{

  if(await networkInfo.isConnected){
    try{
      final response = await callback();
      return Right(response);
    } on ServerExecption{
      return Left(ServerFailure());
    }on InvalidEmailOrPasswordExecption{
      return Left(InvalidEmailOrPasswordFailure());
    } on CustomerExistisExecption{
      return Left(CustomerExistisFailure());
    } on AccountNotActiveExecption {
      return Left(AccountNotActiveFailure());
    }
  }else{
    return Left(OfflineFailure());
  }

}