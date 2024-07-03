import 'package:flutter/material.dart';

import '../../../helpers/cache_helper.dart';
import '../../constants/cached/cached_name.dart';

class AppColors {
  ///! hex color  =>  0xFF949496
  static const Color mainOneColor = Color(0xFF949496);
  static const primaryMaterialColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  ///! hex color  =>  0xFF8AE2D9
  static const Color mainTwoColor = Color(0xFFD9D9D9);

  ///! hex color  =>  0xFFCACACC
  static const Color mainThreeColor = Color(0xFFCACACC);

  static const Color mainForeColor = Color(0xFFD3CDDB);
//==================================

  static const Color secondaryOneColor = Color(0xFF000000);

  ///! hex color  =>  0xFFDFDAFF
  static const Color secondaryTwoColor = Color(0xFF9969C4);

  ///! hex color  =>  0xFFDFDAFF
  static const Color secondaryThreeColor = Color(0xFFB77ABD);

//==================================
  ///! hex color  =>  0xFF191919

  static const Color grayColor = Color(0xFF191919);

  static const Color grayOneColor = Color(0xFF58585A);

  ///! hex color  =>  0xFF4C4C4C
  static const Color grayTwoColor = Color(0xFF949496);

  ///! hex color  =>  0xFFC4C4C4
  static const Color grayThreeColor = Color(0xFFC4C4C4);

// //! hex color => 0xCC4C4C4C
  static const Color grayForeColor = Color(0xCC4C4C4C);
  //==================================
//! hex color => 0xFFBF4E4E
  static const Color redOneColor = Color(0xFFBF4E4E);
//! hex color => 0x18BF4E4E
  static const Color redTwoColor = Color(0x18BF4E4E);
//! hex color => 0xCC4C4C4C
  static const Color redThreeColor = Color.fromARGB(204, 255, 0, 0);
  //! hex color => 0xCC4C4C4C
  static const Color redForeColor = Color(0xffAE2328);
//==================================
//! hex color => 0xFF4EBF7F
  static const Color greenOneColor = Color(0xFF4EBF7F);

//! hex color => 0xCC4C4C4C
  static const Color greenTwoColor = Color.fromARGB(23, 78, 191, 93);

//! hex color => 0xCC00FF37
  static const Color greenThreeColor = Color(0xCC00FF37);
}

class AppGradientColors {
  ///! hex color  =>  0xFF949496
  static const LinearGradient mainGradien = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.topLeft,
    stops: [0.1562, 0.3241, 0.6403, 0.8438],
    colors: [
      Color(0xFF000000),
      Color(0xFF000000),
      Color(0xFF949496),
      Color(0xFF949496),
    ],
    transform: GradientRotation(245.56 * (3.1415 / 180)),
  );

  static const LinearGradient secondaryGradien = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0288, 0.3243, 0.4678, 0.5863, 0.7703, 0.9983],
      colors: [
        Color(0xFF9969C4),
        Color(0xFF8F5FB8),
        Color(0xFF8554AD),
        Color(0xFF7D4CA3),
        Color(0xFF744298),
        Color(0xFF68368B),
      ],
      transform: GradientRotation(228.93 * (3.1415 / 180)));

  static LinearGradient whiteGradien = LinearGradient(
      colors: CacheHelper.getString(LANGUAGE_TYPE_CACHED) == "ar"
          ? const [
              Color.fromRGBO(253, 252, 252, 0),
              Color.fromRGBO(253, 252, 252, 0.4),
              Color.fromRGBO(253, 252, 252, 0.6),
              Color.fromRGBO(253, 252, 252, 0.6),
            ]
          : const [
              Color.fromRGBO(253, 252, 252, 0.6),
              Color.fromRGBO(253, 252, 252, 0.6),
              Color.fromRGBO(253, 252, 252, 0.4),
              Color.fromRGBO(253, 252, 252, 0),
            ]);
}

class AppBoxDecoration {
  static BoxDecoration containerDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
            offset: Offset(-1, 1),
            blurRadius: 5,
            spreadRadius: 0.1,
            blurStyle: BlurStyle.solid,
            color: Color.fromRGBO(61, 61, 61, 0.07)),
        BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 5,
            spreadRadius: 0.1,
            blurStyle: BlurStyle.solid,
            color: Color.fromRGBO(61, 61, 61, 0.07))
      ]);

  static const BoxDecoration mainBoxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(61, 61, 61, 0.08),
          blurRadius: 40.0,
          offset: Offset(0.0, 4.0),
        )
      ]);

  static const BoxDecoration secondaryBoxDecoration = BoxDecoration(
    color: Color.fromRGBO(153, 105, 196, 0.1),
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.05),
        offset: Offset(0, 4),
        blurRadius: 12,
      ),
    ],
  );

  static const BoxDecoration greenBoxDecoration = BoxDecoration(
    color: Color.fromRGBO(24, 24, 24, 0.433),
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.05),
        offset: Offset(0, 4),
        blurRadius: 12,
      ),
    ],
  );
}
