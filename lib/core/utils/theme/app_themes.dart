import 'package:flutter/material.dart';
import 'package:moms_care/core/utils/theme/font_manager.dart';


ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'ShamelBook',
    appBarTheme: appBarTheme()
  );
}
TextTheme textTheme(){
  return const TextTheme(
    titleMedium: TextStyle(fontSize:FontSizeManager.s16)
  );
}
AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.blue,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  );
}