import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/enam/course_types.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/button_navigation_widget.dart';
import 'package:moms_care/core/widget/button/floating_action_button.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/core/widget/video/youtube_player_widget.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';
import 'package:moms_care/features/courses/persention/pages/add_update_course_page.dart';
import 'package:moms_care/features/courses/persention/pages/course_details.dart';
import 'package:moms_care/features/courses/persention/widget/course_card_widget.dart';

import 'package:moms_care/features/courses/persention/widget/course_widget.dart';
import 'package:moms_care/injection_container.dart' as di;

import 'package:substring_highlight/substring_highlight.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>   {
  String  textSample = "";
  List<Course>? courses;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create:(context)=> di.sl<CourseBloc>()..add(const GetAllCoursesEvent()),
        child: Scaffold(
          appBar: AppBarPageWidget(pageName: "Courses".tr,),
          bottomNavigationBar: Helper.buttonNavigation,
          body: BlocConsumer<CourseBloc,CourseState>(
            builder:_builderBodyBlocWidget,
            listener:_listenerBodyBlocWidget ,)
        ),
    );
  }

  Widget _builderBodyBlocWidget(BuildContext context, CourseState state) {

    if(state is LoadingCourseState ){
      return const  LoadingVehicleWidget();
    }
    if(state is ErrorCourseState){
      return const ErrorPageWidget();
    }
    else if(state is LoadedCoursesState){
      Get.back();
      courses=state.courses;
      return _buildBodyWidget(context);
    }
    return _buildBodyWidget(context);
  }
  void _listenerBodyBlocWidget(BuildContext context, CourseState state) {

    // if(state is LoadingCourseState ){
    //   MessageBox.showProgress(context, WAIT_MESSAGE);
    // }
    if(state is ErrorCourseState){
      Get.back();
      MessageBox.showError(context, state.message);
      //Center(child: Text(state.message,style: AppTextStyles.getErrorStyle(),),);
    }
    else if(state is LoadedCoursesState){
      Get.back();
      setState(() {
        courses=state.courses;
      });
      // SnackBarBuilder.ShowSuccess(context: context ,message:UPLOAD_IMAGE_SUCCESS_MESSAGE);
      // Get.offAll(HomePage(numberScreen: AppPages.HOME.index,));
    }
  }
  Widget _buildBodyWidget(BuildContext context) {

    return  Stack(
      children: [
        (courses==null) ? const EmptyWidget() : Container(
              padding: EdgeInsets.zero,
              child: ListView.builder(
                itemBuilder: (context,index){
                  final item= courses![index];
                  return  ListTile(
                    title: CourseCardWidget(course: item,onCoursePressed:onSelectedCourse,) ,
                  );
                },
                itemCount: courses!.length,

              ),
            ),
        (Helper.IsAdmin)? FloatingActionButtonWidget(
          icon:Icons.add,
          bottom: 16.0,
          right: 10.0,
          onPressed:onClickAddButton,):const SizedBox(),
      ],
    );
  }
  void onClickAddButton() async{
      Get.off(AddUpdateCoursePage());
      await Future.delayed(Duration(seconds: 2));
  }
  void onSelectedCourse(Course course) async{
    Get.off(CourseDetails(course: course,enableButtonBack: true,));
    await Future.delayed(const Duration(seconds: 2));
    // MessageBox.showDialog(context, textBody: course.title!);
  }
  void onEditCourse(Course course) async{
    Get.off(CourseDetails(course: course,));
    await Future.delayed(Duration(seconds: 2));
    // MessageBox.showDialog(context, textBody: course.title!);
  }









}

