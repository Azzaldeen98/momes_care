
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/theme/app_color.dart';
import 'package:moms_care/config/theme/font_manager.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/features/forum/presentation/pages/post/posts_page.dart';
import 'package:moms_care/features/forum/presentation/wedgits/form_header_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/header_widget.dart';
import 'package:moms_care/features/forum/presentation/wedgits/post_add_update/form_post_widget.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../../../config/theme/color_app.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/enam/input_model_type.dart';
import '../../../../../core/constants/enam/number_of_screen.dart';
import '../../../../../core/utils/dailog/message/message_box.dart';
import '../../../../../core/utils/dailog/message/message_snack_bar.dart';
import '../../../../../core/utils/theme/button_style.dart';
import '../../../../../core/widget/button/button_gr_widget.dart';
import '../../../../../core/widget/button/custom_button.dart';
import '../../../../../core/widget/label/text_widget.dart';
import '../../../../../core/widget/text_field/beauty_textfield.dart';
import '../../../../../core/widget/text_field/text_entry_field.dart';
import '../../../../../core/widget/text_field/text_field_widget.dart';
import '../../../../home/persention/pages/home_page.dart';
import '../../../domain/entities/Post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_state.dart';
import '../../bloc/posts/post_bloc.dart';
import '../../bloc/posts/post_event.dart';
import '../../bloc/posts/post_state.dart';
class AddUpdatePostPage extends StatefulWidget {

const AddUpdatePostPage({Key? key,
    this.post,
   required this.isUpdatePost,
  }): super(key: key);

  final bool isUpdatePost;
  final Post? post;
  // final String? body;


  @override
  State<AddUpdatePostPage> createState() => _AAddUpdatePostPagetState();
}

class _AAddUpdatePostPagetState extends State<AddUpdatePostPage> {

   TextEditingController titleController=TextEditingController();
   TextEditingController bodyController=TextEditingController();
    String? _title;

  @override
  void initState() {

    _title=widget.isUpdatePost?"Update Post".tr : "Add Post".tr;
    if(widget.isUpdatePost==true){
      titleController.text=widget.post!.title!;
      bodyController.text=widget.post!.body!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
      builder: _builderPageBlocState,
      listener: _listenerPageBlocState,
    );
  }

  void _listenerPageBlocState(BuildContext context, AddDeleteUpdatePostState state) {

    if (state is LoadingAddDeleteUpdatePostState) {
      print("LoadedPostsState99");
      MessageBox.showProgress(context!,"Wait..".tr);
    }
    if (state is ErrorAddDeleteUpdatePostState) {
      Get.back();
      // MessageBox.showError(context!, state.message);
      SnackBarBuilder.ShowError(context: context ,message:state.message!);
    } else if (state is AddDeleteUpdatePostSuccessState) {
      titleController.clear();
      bodyController.clear();

    SnackBarBuilder.ShowSuccess(context: context ,message:state.message!);
      Get.offAll(HomePage(numberScreen: NumberOfScreens.FORUM.index,));
      // ScaffoldMessenger.of(context).showSnackBar(  SnackBar(content: Text(state.message!,
      //   style:AppTextStyles.getBasicStyle(color: Colors.white),),
      //   backgroundColor:Colors.green ,));

      // Get.back();


      // MessageBox.showSuccess(context!, state.message!);
      // Navigator.of(widget.baseContext!).pop();
    }

  }
  Widget _builderPageBlocState(BuildContext context, AddDeleteUpdatePostState state) {
    return  KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible)
        {
          return SafeArea(
            bottom: true, top: true, left: true, right: true,
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
            FormHeaderWidget(title:_title!, iconData: Icons.post_add),
            Divider(height: 100,thickness: 0.3,),
            FormPostWidget(isUpdatePost: widget.isUpdatePost,post:(widget.isUpdatePost)?widget.post!:null),
          ],
        ),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     _buildHeaderWidget(context),
        //     SizedBox(height: 20,),
        //     if(widget.inputModelType ==InputModelType.ADD_POST
        //         || widget.inputModelType ==InputModelType.UPDATE_POST)
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
        //          // BlocProvider.of<PostBloc>(context).add(AddPostEvent(title: titleController!.text,content:contentController!.text));
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
