part of 'moms_care_bloc.dart';

abstract class MomsCareEvent extends Equatable {
  const MomsCareEvent();

  @override
  List<Object> get props => [];
}

class GetMomsCareItemsEvent extends MomsCareEvent {
  const GetMomsCareItemsEvent();
}


