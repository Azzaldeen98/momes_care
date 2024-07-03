part of 'sps_bloc.dart';

abstract class SPSState extends Equatable {
  const SPSState();

  @override
  List<Object> get props => [];
}

class SPSInitial extends SPSState {}

//!loading
class LoadingGetSparePartState extends SPSState {}

//!Error
class ErrorGetSparePartState extends SPSState {
  final String message;
  const ErrorGetSparePartState({required this.message});
}

//!Seccessful
class GetSparePartSeccessfulState extends SPSState {
  final List<SparePart>? sparePart;
  const GetSparePartSeccessfulState({required this.sparePart});
}
