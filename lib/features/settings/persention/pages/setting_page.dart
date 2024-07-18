import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:substring_highlight/substring_highlight.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>   {
  String  textSample = "";

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

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

                    ],
                  ),
                ),
              ),

            ],
          )),
    );
  }






}

