
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget{

  const WebViewScreen({super.key,required this.Url});

  final String Url;

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBarPageWidget(pageName: "Web browser".tr,),
    body: WebViewWidget(
        controller: WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
        // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onHttpError: (HttpResponseError error) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )..loadRequest(Uri.parse(Url))),
  );
  }

}


