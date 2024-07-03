import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/theme/color_app.dart';

class LineButtonSheetWidget extends StatelessWidget {
  const LineButtonSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70,
        height: getValueForScreenType<double>(
          context: context,
          mobile: 4,
          tablet: 8,
        ),
        decoration: BoxDecoration(
            color: AppColors.mainOneColor,
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.all(15),
      ),
    );
  }
}
