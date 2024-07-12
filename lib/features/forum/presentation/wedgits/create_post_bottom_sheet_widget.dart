
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/features/forum/presentation/wedgits/text_view_card_header_widget.dart';

import '../../../../config/theme/color_app.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/enam/input_model_type.dart';
import '../../../../core/utils/dailog/message/message_box.dart';
import '../../../../core/utils/theme/button_style.dart';
import '../../../../core/widget/button/button_gr_widget.dart';
import '../../../../core/widget/button/custom_button.dart';
import '../../../../core/widget/label/text_widget.dart';
import '../../../../core/widget/text_field/beauty_textfield.dart';
import '../../../../core/widget/text_field/text_entry_field.dart';
import '../../../../core/widget/text_field/text_field_widget.dart';
import '../../domain/entities/Post.dart';
import '../bloc/post/post_bloc.dart';
import '../bloc/post/post_event.dart';
import '../bloc/post/post_state.dart';
class CreateUpdatePostWidget extends StatefulWidget {

const CreateUpdatePostWidget({Key? key,
    required this.onClickSaved,
    required this.onCreatedOrUpdatedIsSuccess,
    required this.baseContext,
    this.title,
    this.content,
    this.inputModelType=InputModelType.ADD_POST,
  }): super(key: key);

  final Function(String title,String content)  onClickSaved;
  final Function()  onCreatedOrUpdatedIsSuccess;

  final InputModelType  inputModelType;
  final BuildContext?  baseContext;
  final String? title;
  final String? content;
  @override
  State<CreateUpdatePostWidget> createState() => _CreateUpdatePostWidgetState();
}

class _CreateUpdatePostWidgetState extends State<CreateUpdatePostWidget> {

  late Function(String title,String content)  onClickSaved;
  late TextEditingController titleController=TextEditingController();
  late TextEditingController contentController=TextEditingController();
  late Function()  onCreatedOrUpdatedIsSuccess;


  @override
  void initState() {

    if(widget.inputModelType==InputModelType.UPDATE_POST){
      titleController.text=widget.title!;
      contentController.text=widget.content!;
    }else if(widget.inputModelType==InputModelType.UPDATE_COMMENT){
      contentController.text=widget.content!;
    }
    onClickSaved=widget.onClickSaved;
    onCreatedOrUpdatedIsSuccess=widget.onCreatedOrUpdatedIsSuccess;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      builder: _builderPageBlocState,
      listener: _listenerPageBlocState,
    );
  }


  void _listenerPageBlocState(BuildContext context, PostState state) {

    if (state is LoadingPostsState) {
      print("LoadedPostsState99");
      MessageBox.showProgress(widget.baseContext!,"Wait..".tr);
    }
    if (state is ErrorPostsState) {
      Get.back();
      MessageBox.showError(widget.baseContext!, state.message);
    } else if (state is AddPostSuccessState) {
      titleController.clear();
      contentController.clear();
      Get.back();
      // Navigator.of(widget.baseContext!).pop();
      // MessageBox.showSuccess(widget.baseContext!, " succussfly ");
       onCreatedOrUpdatedIsSuccess();
    } else if (state is UpdatedPostSuccessState) {
      titleController.clear();
      contentController.clear();
      Get.back();
      // Navigator.of(widget.baseContext!).pop();
      // MessageBox.showSuccess(widget.baseContext!, " succussfly ");
      onCreatedOrUpdatedIsSuccess();

      //
    }

  }
  Widget _builderPageBlocState(BuildContext context, PostState state) {
    return  SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeaderWidget(context),
            SizedBox(height: 20,),
            if(widget.inputModelType ==InputModelType.ADD_POST
                || widget.inputModelType ==InputModelType.UPDATE_POST)
               TextEntryField(controller: titleController,
                   labelText: "Title",
                   hintText: "Enter Title".tr),

            SizedBox(height: 20,),
            TextEntryField(controller:contentController,
              labelText: "Content",hintText: "Enter Content".tr,
              maxLines: 5,),
            SizedBox(height: 20,),
            CustomButton(
              widthPercent: 80,
              raduis: 10,
              labelText:"Publish".tr,
              icon: Icon(Icons.start,color: AppColor.primaryIconColor,) ,
              bgColor: AppColor.PrimaryButtonLightColor,
              onPressed:() async{
                 // BlocProvider.of<PostBloc>(context).add(AddPostEvent(title: titleController!.text,content:contentController!.text));
                   widget.onClickSaved(titleController!.text,contentController!.text);
                   // Get.back();
                //
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderWidget(BuildContext context){
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
       decoration: BoxDecoration(
         border: Border(bottom: BorderSide(color: AppColor.underLineColor))
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
           children: [
           Text(InputModelSheetTypes[widget.inputModelType.index],
             style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:
             FontWeight.bold),),
             SizedBox(width: 20,),
             Icon(Icons.post_add)
           ],
      ),
    );
   }




}