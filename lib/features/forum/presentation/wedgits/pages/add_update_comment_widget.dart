
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/text_style.dart';

import 'package:moms_care/features/forum/presentation/wedgits/form_header_widget.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../../../core/utils/dailog/message/message_box.dart';
import '../../../../../core/utils/dailog/message/message_snack_bar.dart';
import '../../../domain/entities/Comment.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_bloc.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_state.dart';
import '../comment_add_update/comment_post_widget.dart';

class AddUpdateCommentPage extends StatefulWidget {

const AddUpdateCommentPage({Key? key,
   this.comment,
   required this.isUpdate,
  }): super(key: key);

  final bool isUpdate;
  final Comment? comment;
  // final String? body;


  @override
  State<AddUpdateCommentPage> createState() => _AAddUpdateCommentPageState();
}

class _AAddUpdateCommentPageState extends State<AddUpdateCommentPage> {

   TextEditingController contentController=TextEditingController();
   String? _title;

  @override
  void initState() {

    _title=widget.isUpdate?"Update Comment".tr : "Add Comment".tr;
    if(widget.isUpdate==true){
      contentController.text=widget.comment!.contant!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddDeleteUpdateCommentBloc, AddDeleteUpdateCommentState>(
      builder: _builderPageBlocState,
      listener: _listenerPageBlocState,
    );
  }

  void _listenerPageBlocState(BuildContext context, AddDeleteUpdateCommentState state) {

    if (state is LoadingAddDeleteUpdateCommentState) {
      print("LoadedCommentsState99");
      MessageBox.showProgress(context!,"Wait..".tr);
    }
    if (state is ErrorAddDeleteUpdateCommentState) {
      Get.back();
      SnackBarBuilder.ShowError(context: context ,message:state.message!);
    } else if (state is AddDeleteUpdateCommentSuccessState) {
      contentController.clear();
      SnackBarBuilder.ShowSuccess(context: context ,message:state.message!);
      Navigator.of(context!).pop();
      // Get.offAll(PostsDetails(post: po,));
      // Get.back();
      // MessageBox.showSuccess(context!, state.message!);
      //
    }

  }
  Widget _builderPageBlocState(BuildContext context, AddDeleteUpdateCommentState state) {
    return  KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible)
        {
          return SafeArea(
            child: Scaffold(
              appBar: _buildAppBar(),
              body: _buildBody(isKeyboardVisible) ,
            ),
          );
        });
    }

   AppBar  _buildAppBar(){
    return AppBar(title:Text(_title!),
          backgroundColor: AppColor.primaryAppBarColor,
        );
    }
    Widget _buildBody(bool isKeyboardVisible){
         return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            FormHeaderWidget(title:_title!, iconData: Icons.add_comment),
            Divider(height: 100,thickness: 0.3,),
            FormCommentWidget(isUpdate: widget.isUpdate,comment:(widget.isUpdate)?widget.comment!:null),
          ],
        ),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     _buildHeaderWidget(context),
        //     SizedBox(height: 20,),
        //     if(widget.inputModelType ==InputModelType.ADD_Comment
        //         || widget.inputModelType ==InputModelType.UPDATE_Comment)
        //        TextEntryField(controller: titleController,
        //            labelText: "Title",
        //            hintText: "Enter Title".tr),
        //
        //     SizedBox(height: 20,),
        //     TextEntryField(controller:contentController,
        //       labelText: "Content",hintText: "Enter Content".tr,
        //       maxLines: 5,),
        //     SizedBox(height: 20,),
        //     CustomButton(
        //       widthPercent: 80,
        //       raduis: 10,
        //       labelText:"Publish".tr,
        //       icon: Icon(Icons.start,color: AppColor.primaryIconColor,) ,
        //       bgColor: AppColor.PrimaryButtonLightColor,
        //       onPressed:() async{
        //          // BlocProvider.of<CommentBloc>(context).add(AddCommentEvent(title: titleController!.text,content:contentController!.text));
        //            widget.onClickSaved(titleController!.text,contentController!.text);
        //            // Get.back();
        //         //
        //       }),
        //   ],
        // ),
      ),
    );
    }

  }
