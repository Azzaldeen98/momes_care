




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/utils/theme/font_manager.dart';
import 'package:moms_care/core/utils/theme/color_app.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/data/view_models/date_time_view_model.dart';


class DateTimeWidget  extends StatelessWidget {

  const DateTimeWidget({super.key, this.dateTime});

  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    final dateTimeVM = DateTimeViewModel(dateTime: dateTime!);
    return  Container(
      // color: AppColor.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(vertical:7,horizontal: 20 ),

      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Text(textAlign: TextAlign.start,
                  "${dateTimeVM?.time}" ?? "---",
                  style: AppTextStyles.getMediumStyle( fontSize:
                  FontSizeManager.s12,color: AppColors.grayTwoColor),
                ),
                SizedBox(width: 5,),
                Icon(Icons.access_time_sharp,size: 20,color: AppColors.grayThreeColor,),
              ],
            ),
            SizedBox(width: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Text(textAlign: TextAlign.center,overflow: TextOverflow.fade,
                  "${dateTimeVM?.date} " ?? "---",
                  style: AppTextStyles.getMediumStyle(fontSize:
                  FontSizeManager.s12,color: AppColors.grayTwoColor),
                ),
                SizedBox(width: 5,),
                Icon(Icons.date_range,size: 20,color: AppColors.grayThreeColor),
                SizedBox(width: 5,),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget  _buildControllButtons({BuildContext? context,Function()? onDeleted,Function()? onEdit}){

    return Row(

      children: [
        IconButton(onPressed: onDeleted, icon: Icon(Icons.delete)),
        IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
      ],
    );
  }
}



