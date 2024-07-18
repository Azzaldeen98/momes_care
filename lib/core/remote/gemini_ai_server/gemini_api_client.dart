import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/constants/data.dart';



class GeminiApiClient {
  // final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  late String? _apiKey;
  late final ChatSession _chat;
  late final GenerativeModel _model;
  late final GenerativeModel _visionModel;
  late final  GenerationConfig _generationConfig;

  GeminiApiClient() {
    _apiKey = GEMINI_API_KEY;
    _generationConfig = GenerationConfig(
      temperature: 0.9,
      topK: 1,
      topP: 1,
      maxOutputTokens: 2048,);

    var _history=[
      Content("model", [TextPart("Hello! How can I help you today?".tr)]),
      Content("user", [TextPart("اخبرني عن نفسك")]),
      Content("model", [TextPart("أنا مساعد افتراضي تم تدريبي لتقديم المساعدة والمعلومات حول الرعاية الصحية للأطفال الرضع والأمهات")]),
    ];


    final safetySettings = [
      SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
      SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
      SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
    ];


    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey!,
      generationConfig: _generationConfig,);

    _chat = _model.startChat(history: _history, safetySettings:safetySettings,);


  }

  //   Future<void> fetchData(String prompt) async {
  //
  //   final url = '${GEMINI_BASE_URL}?key=${GEMINI_API_KEY}';
  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   final Map<String, dynamic> body = {
  //     'contents': [
  //       {
  //         'parts': [
  //           {
  //             'text': prompt,
  //             'specialization': Gemini_Model_Specialization,
  //           }
  //         ]
  //       }
  //     ]
  //   };
  //
  //
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: headers,
  //     body: json.encode(body),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final String content = response.body;
  //     // Process the content as needed
  //     print('6Response: $content');
  //   } else {
  //     throw Exception('Failed to fetch data: ${response.statusCode}');
  //   }
  // }

  Future<String> generateText(String text) async {

    String docs="docs".tr;
    if (_apiKey == null) {
      print('No \$API_KEY environment variable');
      exit(1);
    }
    try {
      text="$docs \n  $text  \n ${Gemini_Model_Rules}";
      final content = [Content.text(text)];
      final response = await _model.generateContent(content);
      if (response!=null )
        return response.text!;
      throw Exception("null refrence");
    } catch (e) {
      print("response_error : ${e}");
      throw Exception(e);
    }
  }






}

