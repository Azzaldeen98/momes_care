


import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/constants/api_servers.dart';
import 'package:moms_care/core/constants/constants.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/enam/course_types.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:moms_care/core/remote/firebase/firebase_storage_actions.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/theme/images.dart';
import 'package:moms_care/core/utils/validator/validator.dart';
import 'package:moms_care/core/widget/image/image_widget.dart';
import 'package:moms_care/core/widget/picker/file_picker_demo.dart';
import 'package:moms_care/core/widget/text_field/dropdownbutton_widget.dart';
import 'package:moms_care/features/courses/data/models/course_model.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_bloc.dart';
import 'package:moms_care/features/profile/persention/bloc/profile_event.dart';
import 'package:moms_care/features/profile/persention/widget/image_profile_widget.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/text_style.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';

class FormAddEditCourseWidget extends StatefulWidget{

  final Course? course;
  final bool isUpdate;
  final Function(Course)? onSubmitAdd,onSubmitUpdate;


  const FormAddEditCourseWidget({
    this.isUpdate=false,
    this.course,
    this.onSubmitAdd,
    this.onSubmitUpdate,
  }) ;

  @override
  State<FormAddEditCourseWidget> createState() => _FormAddEditCourseWidgetState();
}

class _FormAddEditCourseWidgetState  extends State<FormAddEditCourseWidget>{

  final _formKey= GlobalKey<FormState>();

  TextEditingController titleController=TextEditingController();
  TextEditingController descriptController=TextEditingController();
  CourseType? _courseType;
  String? _urlFile;
  BuildContext? _context;




  @override
  void initState() {

    if(widget.isUpdate && widget.course!=null){
      titleController.text=widget.course!.title??"";
      descriptController.text=widget.course!.descript??"";
      _courseType=widget.course!.type;
      _urlFile=widget.course!.urlImage;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseBloc,CourseState>(
      builder:_builderBodyBlocWidget,
      listener:_listenerBodyBlocWidget ,);
  }


  Widget _builderBodyBlocWidget(BuildContext context, CourseState state) {

    return _buildBodyPageWidget();
  }

  void _listenerBodyBlocWidget(BuildContext context, CourseState state) async{
    if(state is LoadingUploadFileState || state is LoadingCourseState ){
      MessageBox.showProgress(context, WAIT_MESSAGE);
      await Future.delayed(const Duration(seconds: 5));
    }
    if(state is ErrorCourseState){
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else if(state is AddUpdateDeleteCourseSuccessState){
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context ,message:ADD_SUCCESS_MESSAGE);
      Get.offAll(HomePage(numberScreen: AppPages.COURSES.index,));
      await Future.delayed(const Duration(seconds: 5));
    }
    else if(state is UploadFileSuccessfulState){
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context ,message:UPLOAD_IMAGE_SUCCESS_MESSAGE);
      setState(() {
        print("downloadURL:"+state.downloadURL);
        _urlFile=state.downloadURL;
      });
    }

  }

  Widget _buildBodyPageWidget() {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(widget.isUpdate ? "Update Course".tr: "Add Course".tr,style: AppTextStyles.getTitleStyle(),),
            const SizedBox(height: 40),
            TextFieldWidget(
                controller:titleController,
                multiLines:false,
                name:"Title".tr ,
                validator: (val)=> "".validator()!(val),
                textInputType: TextInputType.name,
                radius: 12,
                padding: 0,
                hintText: "Enter Title".tr),
            const  SizedBox(height: 30,),
            TextFieldWidget(
                controller:descriptController,
                multiLines:true,
                name:"Description".tr ,
                validator:  (val)=> "".validator()!(val),
                textInputType: TextInputType.text,
                radius: 12,
                padding: 0,
                hintText: "Enter Description".tr),
            const  SizedBox(height: 30,),
            DropDownButtonWidget(
              items: CourseType.getStringValues(),
              values: CourseType.values,
              validator:(val)=> "".validatorDropDown()!(val),
              value: _courseType,
              onChange: (value) {
                _courseType = value;
                setState(() {});
              },
              name: "Course Type".tr ,
              radius: 12,
              padding: 0,
            ),
            const  SizedBox(height: 30,),

            // Text("Chose Image".tr,style: AppTextStyles.getTitleStyle(),),
             ImageWidget(urlImage: _urlFile ??  AppImage.RECEIPT, height: 300,width:300 ),

            const SizedBox(height: 30,),
            FilePickerDemo(onChoseFile: onChoseFile,),
            const SizedBox(height: 100,),
            CustomButton(
                widthPercent: 90,
                raduis: 10,
                labelText: widget.isUpdate ? "Update".tr :"Add".tr,
                icon: const Icon(Icons.start,color: AppColor.primaryIconColor,) ,
                bgColor: AppColor.PrimaryButtonLightColor,
                onPressed:() async{
                  validateFormThenUpdateOrAddPost();
                }),
          ],
        ),
      ),
    );
  }

  void onChoseFile(String path) async{
    if(path!=null && path.trim()!="" &&  path!.isValidAllowedFile){

        String? oldUrl=_urlFile;//(_urlFile!=null && _urlFile!.isValidURL)? _urlFile!:null;
        setState(() {_urlFile=path;});
        print("isValidAllowedFile:${oldUrl} \n ${path}");
        var file=File(path!);
        BlocProvider.of<CourseBloc>(context).add(UploadCourseFileEvent(file:file,oldUrl: oldUrl));

        

    // await  FirebaseStorageActions.uploadFileAsync(
    //       file:File(path) ,
    //       folder:STORAGE_COURSES_ID ,
    //        onUploadCompleted:onUploadFileIsCompleted,);
    }
  }
  void onUploadFileIsCompleted(String downloadURL) async{
    if(downloadURL!=null){
      setState(() {_urlFile=downloadURL; });
    }
  }
  void validateFormThenUpdateOrAddPost() async{

    if(_formKey.currentState!.validate()){

      var course=Course(
        title: titleController.text,
        descript: descriptController.text,
        urlImage: _urlFile,
        type: _courseType,
      );

      if(widget.isUpdate && widget.course!=null){
        course=course.copyWith(id: widget.course!.id);
        BlocProvider.of<CourseBloc>(context).add(UpdateCourseEvent(course: course));
          // await widget.onSubmitUpdate!(course!);
      }else{
        // await widget.onSubmitAdd!(course!);
        BlocProvider.of<CourseBloc>(context).add(AddCourseEvent(course: course));
        Get.back();
      }

      }
    }



}
