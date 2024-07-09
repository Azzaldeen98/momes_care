import 'package:dartz/dartz.dart';
import '../../../../core/error/faiture.dart';
import '../../data/data_sourse/sps_datasourse.dart';

abstract class FleetkeyRepostitory {
  Future<Either<Failure, List<SparePart>>> getAllData(String partId);
}
