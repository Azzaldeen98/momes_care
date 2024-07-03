part of 'sps_bloc.dart';

abstract class SPSEvent extends Equatable {
  const SPSEvent();

  @override
  List<Object> get props => [];
}

class GetSparePartEvent extends SPSEvent {
  const GetSparePartEvent();
}

class SearchSparePartEvent extends SPSEvent {
  final String partId;
  const SearchSparePartEvent(this.partId);
}
