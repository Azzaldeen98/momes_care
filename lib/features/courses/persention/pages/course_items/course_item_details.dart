
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/dssd.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/back_button_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/button/update_delete_button_widget.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';
import 'package:moms_care/features/courses/persention/pages/add_update_course_page.dart';
import 'package:moms_care/features/courses/persention/pages/course_items/add_update_course_item_page.dart';
import 'package:moms_care/features/courses/persention/pages/course_items/course_items_page.dart';
import 'package:moms_care/features/courses/persention/widget/course_items/course_item_widget.dart';
import 'package:moms_care/features/courses/persention/widget/course_widget.dart';
import 'package:moms_care/features/courses/persention/widget/functions.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;
class CourseItemDetails extends StatelessWidget{

  const CourseItemDetails({super.key, required this.courseItem, required this.course});
  final CourseItem courseItem;
  final Course course;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create:(context)=> di.sl<CourseBloc>(),
     child:  Scaffold(
          appBar: AppBarPageWidget(pageName: "Course Item Details".tr,actions: [
            BackButtonWidget(
                onPressed:()=> Get.offAll(CourseItemsPage(course:course ,))),
          ],),
          body:BlocConsumer<CourseBloc,CourseState>(
          builder:_builderBodyBlocWidget,
          listener:_listenerBodyBlocWidget ),
      ),
    );
  }
  Widget _builderBodyBlocWidget(BuildContext context, CourseState state) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              if(courseItem!=null)  ...[
                CourseItemWidget(courseItem:courseItem,courseId: courseItem.course?.id,),
                UpdateDeleteButtonWidget(onUpdate:()=>onUpdateCourseItem(context) ,
                    onDelete:()=>onDeleteCourseItem(context)),
              ],
            ],
          ),
        ),
      ),
    );
  }

void _listenerBodyBlocWidget(BuildContext context, CourseState state) async{
    if(state is LoadingCourseState){
      MessageBox.showProgress(context, WAIT_MESSAGE);
      await Future.delayed(const Duration(seconds: 5));
    }
    if(state is ErrorCourseState){
      Get.back();
      MessageBox.showError(context, state.message);
      await Future.delayed(const Duration(seconds: 5));
    }
    else if(state is AddUpdateDeleteCourseSuccessState){
      // MessageBox.showError(context, state.message);
      SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
      Get.offAll(CourseItemsPage(course:course,));
      // Get.back();
       await Future.delayed(const Duration(seconds: 5));
    }



  }

 void onUpdateCourseItem(BuildContext context) async{
     MessageBox.showDialog(context, textBody: "onUpdateCourseItem");
     Get.offAll(AddUpdateCourseItemPage(courseItem:courseItem,course:course,));
     await Future.delayed(const Duration(seconds: 2));
  }

  void onDeleteCourseItem(BuildContext context) async{
    ShowAwesomeDialogBox(context:context,dialogType: DialogType.question ,message: DELETE_CONSENT_MESSAGE,onAccept:() async{
      if(courseItem!=null) {
        BlocProvider.of<CourseBloc>(context).add(DeleteCourseItemEvent(id: courseItem!.id!,UrlMedia:courseItem!.url));
      }
    } );
    await Future.delayed(const Duration(seconds: 2));

  }

}