import 'package:flutter/material.dart';
import '../../utils/theme/color_app.dart';
import '../../utils/theme/text_style.dart';

class TextPriceNameWidget extends StatelessWidget {
  const TextPriceNameWidget({
    super.key,
    required this.price,
    this.fontWeight = FontWeight.w400,
    required this.currencyType,
    this.priceSize = 24,
    this.descSize = 18,
  });
  final String price;
  final String currencyType;
  final FontWeight fontWeight;
  final double priceSize;
  final double descSize;
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
          text: price.split(".").firstOrNull ?? "",
          style: AppTextStyles.getMediumStyle(
              fontSize: priceSize,
              fontWeight: fontWeight,
              color: AppColors.secondaryOneColor),
        ),
        TextSpan(
          text: price.split(".").length > 1 ? ".${price.split(".")[1]}" : "",
          style: AppTextStyles.getBoldStyle(
              fontSize: descSize,
              fontWeight: fontWeight,
              color: AppColors.secondaryOneColor),
        ),
        TextSpan(
          text: currencyType,
          style: AppTextStyles.getMediumStyle(
              fontSize: descSize,
              fontWeight: fontWeight,
              color: AppColors.grayOneColor),
        ),
      ],
    ));
  }
}
