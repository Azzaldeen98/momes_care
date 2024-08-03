
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/back_button_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/button/floating_action_button.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/core/widget/state/error_page_widget.dart';
import 'package:moms_care/core/widget/state/loading_widget.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';
import 'package:moms_care/features/courses/persention/pages/course_details.dart';
import 'package:moms_care/features/courses/persention/pages/course_items/add_update_course_item_page.dart';
import 'package:moms_care/features/courses/persention/pages/course_items/course_item_details.dart';
import 'package:moms_care/features/courses/persention/widget/course_items/course_item_widget.dart';
import 'package:moms_care/features/courses/persention/widget/course_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/injection_container.dart' as di;


class CourseItemsPage extends StatefulWidget {

  const CourseItemsPage({super.key, required this.course});
  final Course course;
  @override
  State<CourseItemsPage> createState() =>_CourseItemsPageState();
}
class _CourseItemsPageState extends State<CourseItemsPage> {
  List<CourseItem>? courseItems;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> di.sl<CourseBloc>()..add(GetAllCourseItemsEvent(courseId: widget.course!.id ?? 0)),
      child:  Scaffold(
        appBar: _buildAppBarWidget(),
        body:BlocConsumer<CourseBloc,CourseState>(
            builder:_builderBodyBlocWidget,
            listener:_listenerBodyBlocWidget ),
      ),
    );
  }
  AppBarPageWidget _buildAppBarWidget(){
    return  AppBarPageWidget(pageName: "Course Items".tr,actions: [
      BackButtonWidget(
          onPressed:()=> Get.offAll(CourseDetails(course:widget.course))),
    ],);
  }
  Widget _builderBodyBlocWidget(BuildContext context, CourseState state) {
        if(state is LoadingCourseState ){
          return const  LoadingVehicleWidget();
        }
        if(state is ErrorCourseState){
           return const ErrorPageWidget();
        }
        else if(state is LoadedCourseItemsState){
            Get.back();
            courseItems=state.courseItems;
            return _buildBodyWidget(context);
        }
        return _buildBodyWidget(context);
  }
  void _listenerBodyBlocWidget(BuildContext context, CourseState state) {

      if(state is ErrorCourseState){
        Get.back();
        MessageBox.showError(context, state.message);
      }
      else if(state is LoadedCoursesState) {
        Get.back();
      }
  }
  Widget _buildBodyWidget(BuildContext context) {
      return Stack(
       children: [
         (courseItems==null || courseItems!.isEmpty)
             ? const EmptyWidget()
             : Container(
           padding: EdgeInsets.zero,
           child: ListView.builder(
             itemBuilder: (context,index){
               CourseItem item= courseItems![index];
               return  ListTile(
                 title: CourseItemWidget(courseId:widget.course.id ,
                   courseItem: item,
                   onCourseItemPressed:onSelectedCourseItem,) ,
               );
             },
             itemCount: courseItems!.length,

           ),
         ) ,

         (Helper.IsAdmin)? FloatingActionButtonWidget(
           icon:Icons.add,
           bottom: 16.0,
           right: 10.0,
           onPressed:onClickAddButton,):const SizedBox(),
       ],
      );
  }


  void onClickAddButton() async{
    Get.off(AddUpdateCourseItemPage(course: widget.course!,));
    await Future.delayed(const Duration(seconds: 2));
  }
  void onSelectedCourseItem(CourseItem item) async{
    Get.off(CourseItemDetails(courseItem: item, course:widget.course ,));
    await Future.delayed(const Duration(seconds: 2));
  }


  // void onUpdateCourseItem(BuildContext context) async{
  //
  // }
  // void onDeleteCourseItem(BuildContext context) async{
  //
  // }
}
