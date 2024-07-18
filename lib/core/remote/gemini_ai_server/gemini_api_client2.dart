// import 'dart:io';
// import 'dart:ui';
// import 'package:get/get.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:moms_care/core/constants/api_servers.dart';
// import 'package:moms_care/core/constants/data.dart';
//
//
//
// class GeminiApiClient {
//   // final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
//   late String? _apiKey;
//   late final ChatSession _chat;
//   late final GenerativeModel _model;
//   late final GenerativeModel _visionModel;
//   late final  GenerationConfig _generationConfig;
//
//   GeminiApiClient() {
//     _apiKey = GEMINI_API_KEY;
//     _generationConfig = GenerationConfig(
//       temperature: 0.9,
//       topK: 1,
//       topP: 1,
//       maxOutputTokens: 2048,);
//
//     var history=[
//       Content("model", [TextPart("Hello! How can I help you today?".tr)]),
//       Content("user", [TextPart("اخبرني عن نفسك".tr)]),
//       Content("model", [TextPart("أنا مساعد افتراضي تم تدريبي لتقديم المساعدة والمعلومات حول الرعاية الصحية للأطفال الرضع والأمهات".tr)]),
//     ];
//     Content _systemInstruction = Content(
//         "system", [
//           TextPart(  "هذا النموذج سيكون متخصص في  موضوع  الرعاية الصحية للأطفال الرضع والأمهات في جميع المحادثات."),
//           TextPart(  "يجب أن تكون الردود مفيدة ومختصرة وواضحة ذات معنى ."),
//           TextPart(  "يجب عدم إعادة أي رموز أو أشكال أخرى غير الحروف الهجائية"),
//           TextPart(  "يجب عدم إعادة أي نص أو كلام آخر لا يتعلق بالموضوع المحدد"),
//           TextPart(  "يجب الاعتذار عن الرد في حال كان السؤال  متعلق بالمواضيع  السياسية، الاقتصادية، الرياضة، الجنسية، العسكرية, الغير اخلاقية , الطائفية, السب ,الشتم والثقافة الجنسية وغيرها من المواضيع التي ليس لها أي علاقة بموضوع الرعاية الصحية للأطفال الرضع والأمهات "),
//           TextPart(  "يمكن ان تعرف بنفسك ومجال تخصصك وتسأل عن حال المستخدم والاطفال وترد التحية وتلقي السلام وغيرها من الامور الاخلاقية في حال طلب المستخدم ذلك منك "),
//           TextPart("يجب ان يكون الرد عندما يطلب المستخدم منك فقط ")
//         ]
//     );
//
//     final safetySettings = [
//       SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
//       SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
//       SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
//       SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
//     ];
//
//     _model = GenerativeModel(
//       model: 'gemini-pro',
//       apiKey: _apiKey!,
//       generationConfig: _generationConfig,
//         // systemInstruction: _systemInstruction,
//         // safetySettings:safetySettings,
//     );
// //history: history,
//     _chat = _model.startChat();
//
//
//     _visionModel = GenerativeModel(
//       model: 'gemini-pro-vision',
//       apiKey: _apiKey!,
//       generationConfig: _generationConfig,);
//
//   }
//
//   //   Future<void> fetchData(String prompt) async {
//   //
//   //   final url = '${GEMINI_BASE_URL}?key=${GEMINI_API_KEY}';
//   //   final Map<String, String> headers = {
//   //     'Content-Type': 'application/json',
//   //     'Accept': 'application/json',
//   //   };
//   //   final Map<String, dynamic> body = {
//   //     'contents': [
//   //       {
//   //         'parts': [
//   //           {
//   //             'text': prompt,
//   //             'specialization': Gemini_Model_Specialization,
//   //           }
//   //         ]
//   //       }
//   //     ]
//   //   };
//   //
//   //
//   //   final response = await http.post(
//   //     Uri.parse(url),
//   //     headers: headers,
//   //     body: json.encode(body),
//   //   );
//   //
//   //   if (response.statusCode == 200) {
//   //     final String content = response.body;
//   //     // Process the content as needed
//   //     print('6Response: $content');
//   //   } else {
//   //     throw Exception('Failed to fetch data: ${response.statusCode}');
//   //   }
//   // }
//
//     Future<String> generateText(String text) async {
//     if (_apiKey == null) exit(1);
//
//
//     // Iterable<Content> prompt = [
//     //   Content.text("User: Hello, how are you?"),
//     //   Content.model("Model: I'm doing well, thank you for asking."),
//     // ];
//
//     final Map<String, dynamic> _content = {
//         'contents': [
//           {
//             'parts': [
//               {
//                 'text': text,
//                 'specialization': Gemini_Model_Specialization,
//               }
//             ]
//           }
//         ]
//       };
//     try {
//       // _content="${UserQuestionLabel}:\n ${_content} \n ${Gemini_Model_Rules}";
//       final content = [Content.text(text)];
//       final response = await _model.generateContent(content);
//       print("generateContentResponse: ${response.text}");
//       if (response!=null )
//
//         return response.text!;
//       throw Exception("null refrence");
//     } catch (e) {
//       print("response_error : ${e}");
//       throw Exception(e);
//     }
//   }
//   final List<({Image? image, String? text, bool fromUser})> _generatedContent =
//   <({Image? image, String? text, bool fromUser})>[];
//
//
//
// // Future<String> generateTextByImage(String prompt,  final XFile? imageFile) async{
// //   print("prompt : $prompt");
// //   prompt+=". "+"Language".tr;
// //
// //   if (_apiKey == null ) {
// //     print('No \$API_KEY environment variable');
// //     exit(1);
// //   }
// //   if (imageFile==null) {
// //     print('No imageFile its null !!');
// //     // throw CustomException(CustomErrorType.FileIsNull, 'No imageFile its null !!');
// //
// //   } else {
// //
// //     // try {
// //     final firstImage = await (imageFile?.readAsBytes());
// //     final imageParts = [DataPart('image/jpeg', firstImage!)];
// //     final response = await _visionModel.generateContent(
// //         [Content.multi([TextPart(prompt), ...imageParts])]);
// //     if (response != null)
// //       return response.text!;
// //     else
// //       throw Exception("null refrence");
// //     // } catch (e) {
// //     //   print("response_error : ${e}");
// //     //   throw Exception(e);
// //     // }
// //   }
// // }
//
//
// }
//
