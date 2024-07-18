import 'package:dartz/dartz.dart';
import 'package:moms_care/core/resources/data_state.dart';
import 'package:moms_care/core/usecase/usecase.dart';
import 'package:moms_care/features/daily_news/domain/entities/article.dart';
import 'package:moms_care/features/daily_news/domain/repository/article_repository.dart';

import 'package:moms_care/core/error/faiture.dart';
import '../repositories/moms_care_repository.dart';

class GetMomsCareItemsUseCase {
  
  final MomsCareRepository _momsCareRepository;

  GetMomsCareItemsUseCase(this._momsCareRepository);
  
  @override
  Future<Either<Failure,List<dynamic>>> call() async {
    return await _momsCareRepository.getItems();
  }
  
}