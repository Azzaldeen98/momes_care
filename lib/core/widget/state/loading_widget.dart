import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/theme/images.dart';

class LoadingVehicleWidget extends StatelessWidget {
  const LoadingVehicleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(TypeImage.LOADING_FLOWER, width: 150, height: 150));
  }
}
