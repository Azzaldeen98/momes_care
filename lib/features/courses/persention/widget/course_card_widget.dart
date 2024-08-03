  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';



class CourseCardWidget extends StatelessWidget {
  final Course ? course;
  final double? textPositionTop;
  final void Function(Course course) ? onCoursePressed;
  final  Function(Course course)? onEdit;
  const CourseCardWidget({
    Key ? key,
    this.course,
    this.textPositionTop=70,
    this.onCoursePressed,
    this.onEdit
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    var raduis=BorderRadius.circular(20);
    var heightCard=Helpers.getHeightPercent(context,30);
    var widthCard=MediaQuery.of(context).size.width;
    
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        height: heightCard,
        width:  widthCard,
        decoration: BoxDecoration(
          borderRadius: raduis,

          // image:DecorationImage(
          //     image: NetworkImage(course!.urlImage!),
          //     fit: BoxFit.cover),
        ),
        // padding:const EdgeInsetsDirectional.all(0),
          child: Stack(
              alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: raduis,
                ),
                child: ImageWidget(
                  radius: 20,
                  urlImage: course!.urlImage!,
                  width: widthCard,
                  fit: BoxFit.cover,),
              ),
              Container(
                 width: widthCard,
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: raduis,
                    color: const Color.fromRGBO(0, 0, 0, 0.3)
                ),
              ),
              Positioned(
                top: Helpers.getPercentValue(heightCard,textPositionTop!),
                child: Column(
                  children: [
                    Container(
                      padding:const EdgeInsetsDirectional.all(10),
                      width:  MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: raduis,
                          color: const Color.fromRGBO(0, 0, 0, 0.5)
                      ),
                      child: Center(
                        child: Text(
                          course!.title?? '',
                          maxLines : 3,
                          overflow : TextOverflow.ellipsis,
                          style: AppTextStyles.getTitleStyle(color: AppColor.PrimaryTextLightColor),
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              // (Helper.isAdmin)? Positioned(
              //   top: Helpers.getPercentValue(heightCard,82),
              //   right:Helpers.getPercentValue(widthCard,5) ,
              //   child: Container(
              //     height: 40,
              //     padding: EdgeInsets.zero,
              //     decoration: BoxDecoration(
              //       border: Border.all(color:AppColor.primaryIconColor ),
              //       borderRadius: BorderRadius.circular(10)
              //     ),
              //       child: IconButton(
              //         icon:const Icon(Icons.edit,color:AppColor.primaryIconColor,),
              //         onPressed: _onClickEdit,)),
              // ) : const SizedBox(),

              // SizedBox(height: 20,),
              // _buildImage(context),
              // SizedBox(height: 20,),
              // _buildTitleAndDescription(),
              // _buildRemovableArea(),
            ],
          ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: course!.urlImage!,
      imageBuilder : (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width:double.maxFinite ,
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

  Widget _buildTitleAndDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
                child: Text(
                  course!.descript ?? '',
                ),
            ),
            SizedBox(height: 20,),
            // Datetime
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                  const SizedBox(width: 4),
                    Text(
                      course!.createdAt!.toIso8601String() ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
              ],
            ),
            Divider(height: 10,),
          ],
        ),
    );
  }

  void _onTap() {
    if (onCoursePressed != null) {
      onCoursePressed!(course!);
    }
  }

  void _onClickEdit() async{
    if (onEdit != null && Helper.isAdmin) {
     await onEdit!(course!);
    }
  }
}