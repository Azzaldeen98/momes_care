import 'package:dartz/dartz.dart';

import 'package:moms_care/core/error/faiture.dart';

abstract class MomsCareRepository{

  Future<Either<Failure, List<String>>> getItems();

}