
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/theme/text_style.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/features/forum/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';

import 'package:moms_care/features/forum/presentation/wedgits/form_header_widget.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import '../../../domain/entities/Comment.dart';
import '../../../domain/usecases/Comment/add_Comment_use_case.dart';
import '../../../domain/usecases/Comment/delete_Comment_use_case.dart';
import '../../../domain/usecases/Comment/get_all_Comments_use_case.dart';
import '../../../domain/usecases/Comment/like_unlike_Comment_use_case.dart';
import '../../../domain/usecases/Comment/update_Comment_use_case.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_bloc.dart';
import '../../bloc/add_delete_update_comment/add_delete_update_comment_state.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_state.dart';
import '../../bloc/comments/Comment_state.dart';
import '../../bloc/comments/comment_bloc.dart';
import '../../bloc/posts/post_bloc.dart';
import '../../bloc/posts/post_state.dart';
import '../comment_add_update/form_comment_widget.dart';
import 'package:moms_care/injection_container.dart' as di;

class AddUpdateCommentPage extends StatefulWidget {

const AddUpdateCommentPage({Key? key,
   this.comment,
   required this.isUpdate,
   required this.onComplated,
  }): super(key: key);

  final bool isUpdate;
  final Comment? comment;
  final Function(BuildContext context,String content) onComplated;
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

    return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdateState>(
      builder:_builderPageBlocState,
      listener:_listenerPageBlocState,
    );
  }

  void _listenerPageBlocState(BuildContext context, AddDeleteUpdateState state) {

    if (state is LoadingAddDeleteUpdateState) {
      print("LoadedCommentsState99");
      MessageBox.showProgress(context!,WAIT_MESSAGE);
    }
    if (state is ErrorAddDeleteUpdateState) {
      Get.back();
      SnackBarBuilder.ShowError(context: context ,message:state.message!);
    } else if (state is AddDeleteUpdateSuccessState) {
      contentController.clear();
      SnackBarBuilder.ShowSuccess(context: context ,message:state.message!);
      widget.onComplated(context,contentController!.text);
      Get.back();
      Get.back();

    }

  }
  Widget _builderPageBlocState(BuildContext context, AddDeleteUpdateState state) {
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
            FormHeaderWidget(title:_title!, iconData: Icons.add_comment),
            Divider(height: 100,thickness: 0.3,),
            FormCommentWidget(
                isUpdate: widget.isUpdate,
                comment:widget.comment!),
          ],
        ),

      ),
    );
    }

  }
