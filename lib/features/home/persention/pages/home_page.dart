import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/local/locale_controller.dart';
import 'package:moms_care/config/routes/routes_name.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/features/daily_news/domain/entities/article.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:moms_care/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:moms_care/features/moms_care/presentation/bloc/local/speech/commands.dart';
import 'package:moms_care/features/moms_care/presentation/bloc/local/speech/speech.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String textSample = "";//'Click button to start recording'.tr;
  bool isListening = false;
  bool flag=true;
  String btn_name="Arabic";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title:  Text(
          'Speech Recognition'.tr,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FlutterClipboard.copy(textSample);
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('Text Copied to Clipboard'.tr)),
              );
            },
            icon: const Icon(
              Icons.copy,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: AvatarGlow(
        endRadius: 80,
        animate: isListening,
        glowColor: Colors.teal,
        child: FloatingActionButton(
          onPressed: toggleRecording,
          child: Icon(
            isListening ? Icons.circle : Icons.mic,
            size: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(height: 100,),
              Center(
                child: SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // ElevatedButton(
                      //   onPressed: () {
                      //     LocaleController().chingeLanguage(languageCode: 'ar');
                      //   },
                      //   child: Text("Arabic"),
                      // ),
                      ElevatedButton(
                        onPressed: () {

                          setState(() {
                            btn_name=(!flag)?"English":"Arabic";
                          });
                          LocaleController().chingeLanguage(languageCode: (flag)?'en':'ar');
                          flag=!flag;
                        },
                        child: Text(btn_name),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0).copyWith(bottom: 140),
                child: SubstringHighlight(
                  text: textSample,
                  textAlign: TextAlign.center,
                  terms: Command.commands,
                  textStyle: const TextStyle(

                    color: Colors.teal,
                    fontSize: 30,
                  ),
                  textStyleHighlight: const TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }

  Future toggleRecording() => Speech.toggleRecording(
      onResult: (String text) => setState(() {
        textSample = text;
      }),
      onListening: (bool isListening) {
        setState(() {
          this.isListening = isListening;
        });
        if (!isListening) {
          Future.delayed(const Duration(milliseconds: 5000), () {
            Utils.scanVoicedText(textSample);
          });
        }
      });
}

