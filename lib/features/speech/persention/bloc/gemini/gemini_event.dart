



import 'package:equatable/equatable.dart';

class GeminiEvent extends Equatable{
  const GeminiEvent();
  @override
  List<Object?> get props => [];
}


class AskGeminiEvent extends GeminiEvent{
  final String inputText;
  const AskGeminiEvent({required this.inputText});
}