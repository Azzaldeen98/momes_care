part of 'speech_bloc.dart';

abstract class SpeechState extends Equatable {
  const SpeechState();

  @override
  List<Object> get props => [];
}

class SpeechInitial extends SpeechState {}

//!loading
class SpeechLoadingState extends SpeechState {}

//!Error
class ErroreSpeechSeccessfulState extends SpeechState {
  final String message;
  const ErroreSpeechSeccessfulState({required this.message});
}


class GetSpeechSeccessfulState extends SpeechState {
  final String result ;
  const GetSpeechSeccessfulState({required this.result});
}
