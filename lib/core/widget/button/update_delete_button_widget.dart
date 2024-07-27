
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
class UpdateDeleteButtonWidget extends StatelessWidget {

  const UpdateDeleteButtonWidget({super.key,
    required this.onUpdate,
    required this.onDelete});

  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return (Helper.IsAdmin) ? Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        border:const Border(bottom:BorderSide(color:AppColor.opacitybgCololr), ),
          borderRadius: BorderRadius.circular(0)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomButton(
              height: 50,
              widthPercent: 10,
              labelText: "",
              icon: const Icon(
                Icons.edit, color: AppColor.primaryLightIconColor,),
              onPressed: onUpdate),
          Container(
            width: 1,
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              // color: AppColor.primaryTextColor,
              border: Border.symmetric(
                  vertical: BorderSide(color: Colors.black26, width: 2)),
            ),
          ),
          const SizedBox(width: 10),
          CustomButton(
              height: 50,
              widthPercent: 10,
              labelText: "",
              icon: const Icon(
                  Icons.delete, color: AppColor.primaryLightIconColor),
              onPressed: onDelete),
        ],
      ),
    ) : const SizedBox();
  }
}