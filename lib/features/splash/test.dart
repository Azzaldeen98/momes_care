import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';




class TextToSpeechExample extends StatefulWidget {
  @override
  _TextToSpeechExampleState createState() => _TextToSpeechExampleState();
}

class _TextToSpeechExampleState extends State<TextToSpeechExample> {
  FlutterTts? flutterTts;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  Future<void> _speak(String text) async {
    await flutterTts!.setLanguage("ar_DZ");
    var languages=await flutterTts!.getLanguages;
    print("Languages: ${jsonEncode(languages.toString())}");
   var rts= await flutterTts!.isLanguageInstalled("ar_DZ");
    print("isLanguageAvailable: ${jsonEncode(rts)}");
    await flutterTts!.setPitch(1.0);
    await flutterTts!.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speech Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter text to speak',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                 await  _speak(textEditingController.text);
              },
              child: Text('Speak'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterTts!.stop();
    super.dispose();
  }
}
