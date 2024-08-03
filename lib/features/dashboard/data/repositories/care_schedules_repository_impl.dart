import 'package:dartz/dartz.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:moms_care/core/controller/work_on_servers/network/network_info.dart';
import 'package:moms_care/core/controller/work_on_servers/remote_task.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/age_group_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/care_type_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/data/dataSourse/remote/daily_care_times_remote_datasourse.dart';
import 'package:moms_care/features/dashboard/domain/entities/age_group.dart';
import 'package:moms_care/features/dashboard/domain/entities/care_type.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/domain/repositories/care_schedules_repository.dart';

 class CareSchedulesRepositoryImpl extends CareSchedulesRepository {

   CareSchedulesRepositoryImpl({
     required this.ageGroupRemoteDataSource,
     required this.careTypeRemoteDataSource,
     required this.dailyCareTimesRemoteDataSource,
     required this.networkInfo});

   final AgeGroupRemoteDataSource ageGroupRemoteDataSource;
   final CareTypeRemoteDataSource  careTypeRemoteDataSource;
   final DailyCareTimesRemoteDataSource  dailyCareTimesRemoteDataSource;
   final NetworkInfo networkInfo;


  @override
  Future<Either<Failure, Tuple2<List<AgeGroup>, List<CareType>>>> getAllAgeGroupsAndCareTypes() async{
   return  safeExecuteTaskWithNetworkCheck<Tuple2<List<AgeGroup>, List<CareType>>>(networkInfo,() async{
      var responseCareType= await careTypeRemoteDataSource.getAll();
      var careTypes =  responseCareType.map((item)=> item.toEntity()).toList();
      var responseAgeGroup= await ageGroupRemoteDataSource.getAll();
      var ageGroups= responseAgeGroup.map((item)=> item.toEntity()).toList();
      return Tuple2(ageGroups,careTypes);
    });




  }

}
