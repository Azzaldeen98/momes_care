


import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/constants/enam/media_type.dart';
import 'package:moms_care/core/error/extination_valid.dart';
import 'package:moms_care/core/helpers/helpers.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/utils/validator/validator.dart';
import 'package:moms_care/core/widget/picker/file_picker_demo.dart';
import 'package:moms_care/core/widget/app_view_media_widget.dart';
import 'package:moms_care/features/courses/data/models/course_item_model.dart';
import 'package:moms_care/features/courses/data/models/course_model.dart';
import 'package:moms_care/features/courses/domain/entities/Course.dart';
import 'package:moms_care/features/courses/domain/entities/course_item.dart';
import 'package:moms_care/features/courses/persention/bloc/course_bloc.dart';
import 'package:moms_care/features/courses/persention/bloc/course_event.dart';
import 'package:moms_care/features/courses/persention/bloc/course_state.dart';

import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';
import 'package:moms_care/features/courses/persention/pages/course_items/course_items_page.dart';

class FormAddEditCourseItemWidget extends StatefulWidget{

  final CourseItem? courseItem;
  final int? courseId;
  final bool isUpdate;
  final Function(CourseItem?)? onSubmitAdd,onSubmitUpdate;


  const FormAddEditCourseItemWidget({super.key,
    this.isUpdate=false,
    this.courseItem,
    this.courseId,
    this.onSubmitAdd,
    this.onSubmitUpdate,
  }) ;

  @override
  State<FormAddEditCourseItemWidget> createState() => _FormAddEditCourseItemWidgetState();
}

class _FormAddEditCourseItemWidgetState  extends State<FormAddEditCourseItemWidget>{

  final _formKey= GlobalKey<FormState>();

  TextEditingController titleController=TextEditingController();
  TextEditingController descriptController=TextEditingController();
  TextEditingController urlController=TextEditingController();
  String? _urlFile ;
  BuildContext? _context;
  MediaTypes? _mediaType;
  bool isViewUploadFile=true;

  @override
  void initState() {

    if(widget.isUpdate && widget.courseItem!=null){
      titleController.text=widget.courseItem!.title??"";
      descriptController.text=widget.courseItem!.descript??"";
      _mediaType=widget.courseItem!.mediaType;
      _urlFile=widget.courseItem!.url;
      _mediaType=widget.courseItem!.mediaType;
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
    return  _buildBodyPageWidget();
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
      SnackBarBuilder.ShowSuccess(context: context ,message:state.message);
      Get.offAll(CourseItemsPage(course: Course(id:widget.courseId),));
      await Future.delayed(const Duration(seconds: 2));
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
              Text(widget.isUpdate ? "Update Course ".tr: "Add Course".tr,style: AppTextStyles.getTitleStyle(),),
              const SizedBox(height: 40),
              TextFieldWidget(
                  controller:titleController,
                  multiLines:false,
                  name:"Title".tr ,
                  validator: (val)=> "".validator()!(val),
                  textInputType: TextInputType.text,
                  radius: 12,
                  padding: 0,
                  hintText: "Enter Title".tr),
              const SizedBox(height: 10,),
              TextFieldWidget(
                  controller:descriptController,
                  multiLines:true,
                  name:"Description".tr ,
                  validator:  (val)=> "".validator()!(val),
                  textInputType: TextInputType.text,
                  radius: 12,
                  padding: 0,
                  hintText: "Enter Description".tr),
              const SizedBox(height: 10,),
              if(_urlFile!=null)
                ViewMediaWidget(mediaURL:_urlFile!,),
              const SizedBox(height: 10,),
              CustomButton(
                  labelText: isViewUploadFile? "Attach link".tr : "Attach file".tr,
                  icon:Icon((isViewUploadFile)? Icons.change_circle_outlined:Icons.upload_file) ,
                  // bgColor: AppColor.opacitybgCololr,
                  textStyle: AppTextStyles.getBasicStyle(),
                   border: Border.all(),
                  onPressed:() {
                    setState(() {isViewUploadFile=!isViewUploadFile;});
                  }),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 0.2),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    _buildUploadFileWidget(),
                    _buildUrlLinkWidget(),
                  ],
                ),
              ),
              const SizedBox(height: 80,),
              CustomButton(
                  widthPercent: 90,
                  raduis: 10,
                  labelText: widget.isUpdate ? "Update".tr :"Add".tr,
                  icon: Icon(widget.isUpdate?Icons.edit:Icons.add,color: AppColor.primaryIconColor,) ,
                  bgColor: AppColor.PrimaryButtonLightColor,
                  onPressed:() async{
                    validateFormThenUpdateOrAddPost();
                  }),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      );
  }
  Widget _buildUrlLinkWidget(){
    return Visibility(
      visible: !isViewUploadFile,
      child: Column(
        children: [
          const SizedBox(height: 30,),
          TextFieldWidget(
              controller:urlController,
              multiLines:false,
              name:"URL Link".tr ,
              validator:  (val)=> (""!.validator()!(_urlFile)==null)?null: "".validatorURL()!(val),
              textInputType: TextInputType.url,
              radius: 12,
              padding: 0,
              hintText: "Enter URL Link".tr),
        ],
      ),
    );

  }
  Widget _buildUploadFileWidget(){
    return Visibility(
      visible: isViewUploadFile,
      child: Column(
        children: [

          const  SizedBox(height: 30,),
          FilePickerDemo(onChoseFile: onChoseFile,),
        ],
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
    }
  }
  void onUploadFileIsCompleted(String downloadURL) async{
    if(downloadURL!=null){
      setState(() {_urlFile=downloadURL; });
    }
  }
  void validateFormThenUpdateOrAddPost() async{

    if(_formKey.currentState!.validate()){
      _urlFile=("".validatorURL()!(urlController.text)==null)?urlController.text:_urlFile;
      var courseItem= CourseItem(
        title: titleController.text,
        descript: descriptController.text,
        url: _urlFile,
        mediaType: Helpers.detectFileType(_urlFile),
        course: Course(id: widget.courseId!)
      );
      print("jsonEncode:${jsonEncode(CourseItemModel.fromEntity(courseItem).toCreateJson())}");
      if(widget.isUpdate && widget.courseItem!=null){
        courseItem=courseItem.copyWith(id: widget.courseItem!.id);
        BlocProvider.of<CourseBloc>(context).add(UpdateCourseItemEvent(courseItem: courseItem));
          // await widget.onSubmitUpdate!(courseItem!);
      }else{
        // await widget.onSubmitAdd!(courseItem!);
        BlocProvider.of<CourseBloc>(context).add(AddCourseItemEvent(courseItem: courseItem));
        Get.back();
      }

      }
    }



}
