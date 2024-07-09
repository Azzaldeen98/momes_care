import 'package:dartz/dartz.dart';
import '../../../../core/error/faiture.dart';
import '../../data/data_sourse/sps_datasourse.dart';
import '../repositories/sps_repostitorese.dart';

class GetSparePartUsecases {
  final FleetkeyRepostitory reostitory;
  GetSparePartUsecases(this.reostitory);
  //call من اجل نستعدي الدالة باسم الكلاس
  Future<Either<Failure, List<SparePart>>> call(String partId) async {
    return await reostitory.getAllData(partId);
  }
}
