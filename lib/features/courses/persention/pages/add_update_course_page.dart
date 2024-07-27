

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/back_button_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';
import 'package:moms_care/features/courses/persention/widget/form_add_edit_course_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;
class AddUpdateCoursePage extends StatefulWidget{

  AddUpdateCoursePage({this.course});
  final Course? course;
  @override
  State<AddUpdateCoursePage> createState() => _AddUpdateCoursePageState();
}
class _AddUpdateCoursePageState extends State<AddUpdateCoursePage>{

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create:(context)=> di.sl<CourseBloc>(),
    child:Scaffold(
      appBar: AppBarPageWidget(pageName: "Courses".tr,actions: [

        BackButtonWidget(onPressed:
          ()=>Get.offAll(HomePage(numberScreen: AppPages.COURSES.index,))),
      ],),
        // bottomNavigationBar: Helper.buttonNavigation,
         body:  _buildBodyWidget(context),
        // body: BlocConsumer<CourseBloc,CourseState>(
        //   builder:_builderBodyBlocWidget,
        //   listener:_listenerBodyBlocWidget ,)
    ),
    );
  }

  void _listenerBodyBlocWidget(BuildContext context,CourseState state){
    this.context=context;
    if(state is LoadingCourseState ){
      MessageBox.showProgress(context, WAIT_MESSAGE);
    }
    if(state is ErrorCourseState){
      Get.back();
      MessageBox.showError(context, state.message);
      //Center(child: Text(state.message,style: AppTextStyles.getErrorStyle(),),);
    }
    else if(state is AddUpdateDeleteCourseSuccessState){
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context ,message:UPLOAD_IMAGE_SUCCESS_MESSAGE);
       Get.offAll(HomePage(numberScreen: AppPages.COURSES.index,));
    }

  }
  Widget _builderBodyBlocWidget(BuildContext context,CourseState state){
    this.context=context;
    if(state is LoadingCourseState ){
      return const  LoadingVehicleWidget();
    }
    if(state is ErrorCourseState){
      return const ErrorPageWidget();//Center(child: Text(state.message,style: AppTextStyles.getErrorStyle(),),);
    }
    else if(state is UploadFileSuccessfulState){
      setState(() {

      });
      return _buildBodyWidget(context);
    }
    return _buildBodyWidget(context);
  }
  Widget _buildBodyWidget(BuildContext contex){
  return
    Padding(
      padding: EdgeInsets.all(8.0),
      child: KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible){
            return  SingleChildScrollView(
                padding: EdgeInsets.only(bottom: isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,),
                child: FormAddEditCourseWidget(
                  isUpdate: widget.course!=null,
                  onSubmitAdd:onSubmitAddCourse,
                  course:widget.course,));
          }),
    );
  }

  onSubmitAddCourse(Course course) async{
          Get.back();
        if(course!=null){
          BlocProvider.of<CourseBloc>(context).add(AddCourseEvent(course: course));
        }

  }

  onSubmitUpdateCourse(Course course) async{

    BlocProvider.of<CourseBloc>(context).add(UpdateCourseEvent(course: course));
  }
}