import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/theme/color_app.dart';
import '../../../../core/widget/label/text_widget.dart';

class ErrorHomeWidget extends StatelessWidget {
  const ErrorHomeWidget({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        Image.asset("assets/images/error-search.png",
            width: 50, color: AppColors.grayTwoColor),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextWidget(error, fontSize: 20, maxLines: 4),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class EmptyHomeWidget extends StatelessWidget {
  const EmptyHomeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        Image.asset("assets/images/error-search.png",
            width: 50, color: AppColors.grayTwoColor),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextWidget(
            "We couldn't find any matching results for your search".tr,
            fontSize: 18,
            maxLines: 4,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextWidget(
            "Make sure you type the word correctly, or try searching with different keywords"
                .tr,
            fontSize: 12,
            maxLines: 4,
          ),
        ),
        const SizedBox(height: 30),
        const SizedBox(height: 10),
      ],
    );
  }
}

class InitialHomeWidget extends StatelessWidget {
  const InitialHomeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        Image.asset("assets/images/search.png", width: 100),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextWidget(
            "What are you looking for?".tr,
            fontSize: 18,
            maxLines: 4,
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
