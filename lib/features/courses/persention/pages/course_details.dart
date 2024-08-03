
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
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';
import 'package:moms_care/features/courses/persention/pages/add_update_course_page.dart';
import 'package:moms_care/features/courses/persention/pages/course_items/course_items_page.dart';
import 'package:moms_care/features/courses/persention/widget/course_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;
class CourseDetails extends StatelessWidget{

  const CourseDetails({super.key,
    required this.course,
  this.enableButtonBack=false});

  final Course course;
  final bool enableButtonBack;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create:(context)=> di.sl<CourseBloc>(),
     child:  Scaffold(
          appBar: AppBarPageWidget(pageName: "Course Details".tr,actions: [
            if(enableButtonBack)
                BackButtonWidget(onPressed:()=> Get.offAll(HomePage(numberScreen:AppPages.HOME.index,))),
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
              if(course!=null)
              CourseWidget(course:course,),
              const SizedBox(height: 10,),
              UpdateDeleteButtonWidget(onUpdate:onUpdateCourse ,onDelete:()=>onDeleteCourse(context)),
             const SizedBox(height: 50,),
              CustomButton(
                  widthPercent: 90,
                  labelText: "View Course Items".tr,
                  icon:const Icon(Icons.visibility,
                    color: AppColor.primaryIconColor,),
                  bgColor: AppColor.buttonPrimaryColor,
                  onPressed:  onViewCourseItems),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
// Widget _buildControlsWidget(BuildContext context){
//     return  (Helper.IsAdmin)? Container(
//       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//       decoration: BoxDecoration(
//         // color: AppColor.opacitybgCololr,
//         border:Border.all(color: AppColor.opacitybgCololr),
//         borderRadius: BorderRadius.circular(10)
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CustomButton(
//               height:50,
//               widthPercent: 10,
//               // border: Border.all(color: AppColor.whiteColor),
//               labelText: "",
//               icon:const Icon(Icons.edit,
//                 color: AppColor.primaryLightIconColor,),
//               onPressed: onUpdateCourse),
//           Container(
//             width: 1,
//             height: 40,
//             margin: EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               // color: AppColor.primaryTextColor,
//                  border:Border.symmetric(vertical:  BorderSide(color: Colors.black26,width: 2)),
//             ),
//           ),
//           const SizedBox(width: 10),
//           CustomButton(
//             // border: Border.all(color: AppColor.whiteColor),
//               height:50,
//               widthPercent: 10,
//               labelText: "",
//               icon:const Icon(Icons.delete,
//                   color: AppColor.primaryLightIconColor),
//               onPressed: ()=> onDeleteCourse(context)),
//         ],
//       ),
//     )
//         :const SizedBox();
// }
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
       Get.offAll(HomePage(numberScreen: AppPages.HOME.index,));
      // Get.back();
       await Future.delayed(const Duration(seconds: 5));
    }



  }


 void onUpdateCourse() async{
      Get.offAll(AddUpdateCoursePage(course: course,));
  }

  void onDeleteCourse(BuildContext _context) async{
    ShowAwesomeDialogBox(context:_context,dialogType: DialogType.question ,message: DELETE_CONSENT_MESSAGE,onAccept:() async{
      if(course!=null) {
        BlocProvider.of<CourseBloc>(_context).add(DeleteCourseEvent(id: course!.id!,oldUrlMedia:course!.urlImage));
      }
    } );

  }

  void onViewCourseItems() {

    Get.offAll(CourseItemsPage(course: course,));
  }
}