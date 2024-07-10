part of 'moms_care_bloc.dart';



abstract class MomsCareState extends Equatable {
  const MomsCareState();
  @override
  List<Object> get props => [];
}

class MomsCareInitial extends MomsCareState {}

//!loading
class LoadingGetMomsCareItemsState extends MomsCareState {}

//!Error
class ErrorGetMomsCareItemsState extends MomsCareState {
  final String message;
  const ErrorGetMomsCareItemsState({required this.message});
}

//!Seccessful
class GetMomsCareItemsSuccessfulState extends MomsCareState {
  final List<dynamic>?  items;
  const GetMomsCareItemsSuccessfulState({required this.items});
}
