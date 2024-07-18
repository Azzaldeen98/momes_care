

import 'package:equatable/equatable.dart';


class GeminiState extends Equatable{

  const GeminiState();
  @override
  List<Object?> get props =>[];

}

class GeminiInitial extends GeminiState{
  const GeminiInitial();
}

class LoadingGeminiState extends GeminiState{
  const LoadingGeminiState();
}

class LoadedGeminiState extends GeminiState{
  final String ressult;
  const LoadedGeminiState({required this.ressult});
}

class ErrorGeminiState extends GeminiState{
  final String message;
  const ErrorGeminiState({required this.message});
}