import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/local/locale_controller.dart';
import 'package:moms_care/core/remote/gemini_ai_server/gemini_api_client.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/speech/persention/bloc/gemini/gemini_bloc.dart';
import 'package:moms_care/features/speech/persention/bloc/gemini/gemini_event.dart';
import 'package:moms_care/features/speech/persention/bloc/gemini/gemini_state.dart';
import 'package:moms_care/features/speech/persention/bloc/local/commands.dart';
import 'package:moms_care/features/speech/persention/bloc/local/speech.dart';

import 'package:substring_highlight/substring_highlight.dart';

import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/injection_container.dart' as di;


class SpeechPage extends StatefulWidget {
  const SpeechPage({Key? key}) : super(key: key);

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  String textSample = "";
  String textResult = "";
  bool isListening = false;
  bool flag=true;
  bool is_visible_loading=false;
  String btn_name="Arabic";
  BuildContext? _context;
  FlutterTts? flutterTts;

  @override
  void initState() {
    flutterTts = FlutterTts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context) => di.sl<GeminiBloc>(),
        child:Scaffold(
          appBar: AppBarPageWidget(pageName: "Voice Chat".tr,),
          bottomNavigationBar: Helper.buttonNavigation ,
          floatingActionButton: _buildAvatarGlow(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body:  BlocConsumer<GeminiBloc,GeminiState>(
              builder: _builderSpeechWidgetBlocState,
              listener: _listenerSpeechBlocState
          )),
        );
  }
  Widget _builderSpeechWidgetBlocState(BuildContext context, state) {

    _context=context;
    return   SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [

            SizedBox(height: 30,),
            Center(
              child: SizedBox(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width:double.maxFinite,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.primaryOpacityBgLight,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SubstringHighlight(
                      text: textSample,
                      textAlign: TextAlign.center,
                      terms: Command.commands,
                      textStyle: AppTextStyles.getLabelStyle(fontSize: FontSizeManager.s20),
                      textStyleHighlight: const TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Visibility(
                    visible: is_visible_loading! ,
                    child: SizedBox(
                      height: 100,
                      child: LoadingVehicleWidget(),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width:double.maxFinite,
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color:  AppColor.primaryOpacityBgLight,width: 3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(textResult,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.getLabelStyle()),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
  Widget _buildAvatarGlow(){
    return AvatarGlow(
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
    );
  }
  void _listenerSpeechBlocState(BuildContext context, state) {

    if(state is LoadingGeminiState){
      // MessageBox.showProgress(context,"Wait..".tr);
    }
    if(state is ErrorGeminiState){
      Get.back();
      setState(() =>is_visible_loading=false);
      MessageBox.showError(context,state.message);

    } else if(state is LoadedGeminiState){
      Get.back();
      setState(() =>is_visible_loading=false);
      _startTyping(state.ressult);
      _startSpeaking(state.ressult);



    }
  }
  void _startSpeaking(String text) async {
    await flutterTts!.setLanguage("en");
    await flutterTts!.setPitch(1.0);
    await flutterTts!.speak(text);
  }
  void _startTyping(String result) async {
    setState(() {
      textResult="";
    });
    for (int i = 0; i < result.length; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      if(result[i]!='*')
          setState(() =>textResult += result[i]);
    }
  }
  Future toggleRecording() => Speech.toggleRecording(

      onResult: (String text) async{
        setState(() {textSample = text;});
      },
      onListening: (bool isListening) async{
        setState(()=>this.isListening = isListening);

        if (!isListening) {
          setState(() =>is_visible_loading=true);
          Future.delayed(const Duration(milliseconds: 5000), () async {

            BlocProvider.of<GeminiBloc>(_context!).add(AskGeminiEvent(inputText: textSample));
            Utils.scanVoicedText(textSample);
          });
        }
      });

  // Future<void> _speak(String text) async {
  //   await flutterTts!.setLanguage("ar_DZ");
  //   var languages=await flutterTts!.getLanguages;
  //   // print("Languages: ${jsonEncode(languages.toString())}");
  //   var rts= await flutterTts!.isLanguageInstalled("ar_DZ");
  //   // print("isLanguageAvailable: ${jsonEncode(rts)}");
  //   await flutterTts!.setPitch(1.0);
  //   await flutterTts!.speak(text);
  // }
}

