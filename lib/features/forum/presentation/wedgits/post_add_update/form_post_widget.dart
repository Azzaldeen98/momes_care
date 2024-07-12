
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../core/widget/button/custom_button.dart';
import '../../../../../core/widget/text_field/text_field_widget.dart';
import '../../../domain/entities/Post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_event.dart';

class FormPostWidget  extends StatefulWidget {

  const FormPostWidget({super.key,required this.isUpdatePost, this.post });
  final  bool isUpdatePost;
  final  Post? post;


  @override
  State<FormPostWidget> createState() => _FormPostWidgetState();

}


class _FormPostWidgetState  extends  State<FormPostWidget> {
   final _formKey= GlobalKey<FormState>();
   TextEditingController titleController=TextEditingController();
   TextEditingController contentController=TextEditingController();


  @override
  void initState() {

    if(widget!.isUpdatePost){
      titleController.text=widget.post!.title!;
      contentController.text=widget.post!.body!;
    }
    super.initState();
  }

  void validateFormThenUpdateOrAddPost() async{

  bool isValid=_formKey.currentState!.validate();
    if(isValid){
      var post=Post(title:titleController!.text,body:contentController!.text);
      if(widget.isUpdatePost){
        post = post.copyWith(id:widget.post!.id);
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(UpdatePostEvent(post: post));
      } else{
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(AddPostEvent(post: post));
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
                labelText: widget.isUpdatePost?"Upadte".tr:"Add".tr,
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
