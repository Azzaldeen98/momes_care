  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/data/view_models/date_time_view_model.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:moms_care/core/widget/label/custom_text_widget.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';



class CourseWidget extends StatelessWidget {
  final Course ? course;
  final bool ? isRemovable;
  final void Function(Course course) ? onRemove;
  final void Function(Course course) ? onCoursePressed;

   CourseWidget({
    Key ? key,
    this.course,
    this.onCoursePressed,
    this.isRemovable = false,
    this.onRemove,
  }): super(key: key);

  DateTimeViewModel? dateTimeView;
  @override
  Widget build(BuildContext context) {

    dateTimeView= DateTimeViewModel(dateTime: course?.createdAt ?? DateTime.now());

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.2)
        ),
        padding:const EdgeInsetsDirectional.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeaderWidget(context),
              const SizedBox(height: 20,),
              _buildImageWidget(context),
              const SizedBox(height: 20,),
              _buildDescriptionWidget(context),
            ],
          ),
      ),
    );
  }

  Widget _buildHeaderWidget(BuildContext context) {
    return   CustomTextWidget(
        "#  ${ course!.title }",
        maxLines: 3,
        textStyle: AppTextStyles.getTitleStyle(color: AppColor.titleTextColor),
        border: const Border(bottom: BorderSide(width: 0.2)));
  }
  Widget _buildImageWidget(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: course?.urlImage??"",
      imageBuilder : (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width:MediaQuery.of(context).size.width ,
          height:300,// MediaQuery.of(context).size.height / 3 ,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover
            )
          ),
        ),
      ),
      progressIndicatorBuilder : (context, url, downloadProgress) => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          // width: MediaQuery.of(context).size.width / 3,
          // height: double.maxFinite,
          width:double.maxFinite ,
          height:MediaQuery.of(context).size.height / 3 ,
          child: CupertinoActivityIndicator(),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
        ),
      ),
      errorWidget : (context, url, error) => 
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          // width: MediaQuery.of(context).size.width / 3,
          // height: double.maxFinite,
          width:double.maxFinite ,
          height:MediaQuery.of(context).size.height / 3 ,// Icon(Icons.error),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
          child: ImageWidget(urlImage: url!=null? url : AppImage.RECEIPT ,)!,
        ),
      )
    );
  }

  Widget _buildDescriptionWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(course?.descript ?? "" ,
            maxLines: 10,
            textStyle:AppTextStyles.getLabelStyle(color: AppColor.titleTextColor) ,
                border: const Border(bottom: BorderSide(width: 0.2)),),
            const SizedBox(height: 10,),
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                  const SizedBox(width: 10),
                    Text("${dateTimeView!.date}  \t - \t   ${dateTimeView!.time}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
              ],
            ),
          ],
        ),
    );
  }



  void _onTap() {
    if (onCoursePressed != null) {
      onCoursePressed!(course!);
    }
  }

}