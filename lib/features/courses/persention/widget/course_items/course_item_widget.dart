import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/widget/app_view_media_widget.dart';
import 'package:moms_care/core/widget/label/custom_text_widget.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';


class CourseItemWidget extends StatelessWidget {
  final CourseItem ? courseItem;
  final int ? courseId;
  final bool ? isRemovable;
  final void Function(CourseItem) ? onRemove;
  final void Function(CourseItem) ? onCourseItemPressed;

  const CourseItemWidget({
    Key ? key,
    this.courseItem,
    this.courseId,
    this.onCourseItemPressed,
    this.isRemovable = false,
    this.onRemove,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding:const EdgeInsetsDirectional.all(0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.2)
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextWidget( "#  ${ courseItem!.title }",
                  textAlign: TextAlign.right,
                  maxLines: 3,
              border: const Border(bottom: BorderSide(width: 0.2))),
              // const SizedBox(height: 20,),
              ViewMediaWidget(mediaURL: courseItem!.url!,),
              const SizedBox(height: 20,),
              CustomTextWidget(courseItem?.descript ?? "",maxLines: 5,textStyle: AppTextStyles.getLabelStyle(fontSize: 14), ),
            ],
          ),
      ),
    );
  }


  void _onTap() {
    if (onCourseItemPressed != null) {
      onCourseItemPressed!(courseItem!);
    }
  }


}



