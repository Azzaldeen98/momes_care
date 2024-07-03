import 'package:flutter/material.dart';
import '../../../config/theme/color_app.dart';
import '../../../config/theme/text_style.dart';
import '../label/text_newprice_widget.dart';
import '../label/text_widget.dart';
import '../image/image_widget.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, this.onDelete, required this.item});
  final Object item;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color.fromARGB(227, 225, 224, 224), width: 0.7),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEBEEF0))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageWiget(
                urlImage: "sparePart.images?.firstOrNull" ?? "",
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextWidget(
                "sparePart.name" ?? "----",
                fontSize: 16,
              ),
              const SizedBox(height: 5),
              TextWidget("sparePart.sparePartId" ?? "----", fontSize: 14),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "sparePart.store?.name" ?? "---",
                      style: AppTextStyles.getMediumStyle(
                          fontSize: 14, color: AppColors.secondaryTwoColor),
                    ),
                  ),
                  TextNewPriceWidget(
                    newPrice: "${'sparePart.price' ?? "--"}",
                    fontSize: 16,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(width: 20),
            ],
          )),
        ],
      ),
    );
  }
}
