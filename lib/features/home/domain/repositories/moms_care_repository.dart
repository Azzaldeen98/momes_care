import 'package:dartz/dartz.dart';

import '../../../../core/error/faiture.dart';

abstract class MomsCareRepository{

  Future<Either<Failure, List<String>>> getItems();

}