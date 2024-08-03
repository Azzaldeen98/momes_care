import 'package:dartz/dartz.dart';
import 'package:moms_care/core/error/faiture.dart';
import 'package:moms_care/features/dashboard/domain/entities/daily_care_times.dart';
import 'package:moms_care/features/dashboard/domain/repositories/daily_care_times_repozitorese.dart';

class GetBabyDailyCareTimesUseCase {

  final DailyCareTimesRepository  _postRepository;
  GetBabyDailyCareTimesUseCase(this._postRepository);

  @override
  Future<Either<Failure,List<DailyCareTimes>>> call(int babyId) async {
    return  await _postRepository.getBabyDailyCareTimes(babyId);
  }

}