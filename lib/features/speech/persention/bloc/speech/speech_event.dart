part of 'speech_bloc.dart';

abstract class SpeechEvent extends Equatable {
  const SpeechEvent();

  @override
  List<Object> get props => [];
}

class GetSpeechEvent extends SpeechEvent {
  final String text;
  const GetSpeechEvent(this.text);
}


