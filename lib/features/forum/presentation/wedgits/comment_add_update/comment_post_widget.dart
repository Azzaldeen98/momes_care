
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/forum/presentation/bloc/add_delete_update_comment/add_delete_update_comment_bloc.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../core/widget/button/custom_button.dart';
import '../../../../../core/widget/text_field/text_field_widget.dart';
import '../../../domain/entities/Comment.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_event.dart';

class FormCommentWidget  extends StatefulWidget {

  const FormCommentWidget({super.key,required this.isUpdate, this.comment });
  final  bool isUpdate;
  final  Comment? comment;
  @override
  State<FormCommentWidget> createState() => _FormCommentWidgetState();

}


class _FormCommentWidgetState  extends  State<FormCommentWidget> {
   final _formKey= GlobalKey<FormState>();
   TextEditingController titleController=TextEditingController();
   TextEditingController contentController=TextEditingController();


  @override
  void initState() {

    if(widget!.isUpdate){
      contentController.text=widget.comment!.contant!;
    }
    super.initState();
  }

  void validateFormThenUpdateOrAddPost() async{

  bool isValid=_formKey.currentState!.validate();
    if(isValid){
      var coment=Comment(contant:contentController!.text);
      if(widget.isUpdate){
        coment = coment.copyWith(id:widget.comment!.id);
        BlocProvider.of<AddDeleteUpdateCommentBloc>(context).add(UpdateCommentEvent(comment: coment));
      } else{
        BlocProvider.of<AddDeleteUpdateCommentBloc>(context).add(AddCommentEvent(comment: coment));
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    return Form(
        key: _formKey,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TextEntryField(controller: titleController,
            //     labelText: "Title",
            //     hintText: "Enter Title".tr),

            SizedBox(height: 10,),
            TextFieldWidget(
                controller:titleController,
                multiLines:false,
                name:"Title".tr ,
                validator: (val)=> val!.isEmpty ? "The title cannot be empty".tr : null,
                textInputType: TextInputType.text,
                radius: 12,
                padding: 0,
                hintText: "Enter Title".tr),
            SizedBox(height: 30,),
            TextFieldWidget(
              controller:contentController,
              multiLines:true,
              name:"Body".tr ,
              hintText: "Enter Body".tr,
              validator: (val)=> val!.isEmpty ? "The body cannot be empty".tr :null,
              textInputType: TextInputType.text,
              radius: 12,
              padding: 0,),
            SizedBox(height: 20,),
            CustomButton(
                widthPercent: 80,
                raduis: 10,
                labelText: widget.isUpdate?"Upadte".tr:"Add".tr,
                icon: Icon(Icons.start,color: AppColor.primaryIconColor,) ,
                bgColor: AppColor.PrimaryButtonLightColor,
                onPressed:() async{
                  validateFormThenUpdateOrAddPost();
                }),

          ],
        ),
    );

  }

}
