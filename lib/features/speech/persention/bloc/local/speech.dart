import 'package:flutter/material.dart';
import 'package:moms_care/core/constants/cached/cached_name.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:moms_care/core/helpers/cache_helper.dart';

class Speech {
  static final _speech = SpeechToText();
  static  bool isAvailable = false;

  static Future<bool> toggleRecording(
      {required Function(String text) onResult,
      required ValueChanged<bool> onListening}) async {

     isAvailable = await _speech.initialize(
        onStatus: (status) => onListening(_speech.isListening),
        onError: (error) => print('Error $error'),);

    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    if (isAvailable) {

      String langCode=CacheHelper.getString(LANGUAGE_TYPE_CACHED)??'en';
      _speech.listen(
          localeId:langCode,
          onResult: (value) => onResult(value.recognizedWords));
    }

    return isAvailable;
  }

  static startListening(Function(String text) onResult){
    if (_speech!=null && _speech.isListening==false) {
      if (isAvailable) {

        String langCode=CacheHelper.getString(LANGUAGE_TYPE_CACHED)??'en';
        _speech.listen(
            localeId:langCode,
            onResult: (value) => onResult(value.recognizedWords));
      }
    }
  }
  static stopListening(){
    if (_speech!=null && _speech.isListening) {
      _speech.stop();
      return true;
    }
  }
}
