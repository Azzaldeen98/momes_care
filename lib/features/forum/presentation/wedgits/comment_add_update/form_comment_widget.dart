
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/features/forum/presentation/bloc/add_delete_update_comment/add_delete_update_comment_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';

import '../../../../../config/theme/app_color.dart';
import 'package:moms_care/core/widget/button/custom_button.dart';
import 'package:moms_care/core/widget/text_field/text_field_widget.dart';
import '../../../domain/entities/Comment.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_event.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_event.dart';

class FormCommentWidget  extends StatefulWidget {

  const FormCommentWidget({super.key,
    required this.isUpdate,
     this.comment,
    });

  final  bool isUpdate;
  final  Comment? comment;
  @override
  State<FormCommentWidget> createState() => _FormCommentWidgetState();

}


class _FormCommentWidgetState  extends  State<FormCommentWidget> {
   final _formKey= GlobalKey<FormState>();
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
      var coment=widget.comment;
       coment = coment?.copyWith(contant:contentController!.text);
      // var coment= Comment(contant:contentController!.text,postId: widget.postId);
      if(widget.isUpdate){
        // coment = coment.copyWith(id:widget.comment!.id);
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(UpdateCommentEvent(comment:coment!));
      } else
      {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(AddCommentEvent(comment: coment!));
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

            SizedBox(height: 30,),
            TextFieldWidget(
              controller:contentController,
              multiLines:true,
              name:"Comment".tr ,
              hintText: "Enter Comment".tr,
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
