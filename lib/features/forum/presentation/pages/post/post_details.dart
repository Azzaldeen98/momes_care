import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/forum/presentation/wedgits/pages/add_update_comment_widget.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_style.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../../domain/entities/Comment.dart';
import '../../bloc/posts/post_bloc.dart';
import '../../bloc/posts/post_state.dart';
import '../../wedgits/comments/comment_widget.dart';
import '../../wedgits/posts/post_widget.dart';

class PostsDetails extends StatefulWidget {

  const PostsDetails({Key? key,required this.post}) : super(key: key);

  final Post post;

  @override
  State<PostsDetails> createState() => _PostsDetailsState();
}

class _PostsDetailsState extends State<PostsDetails> {
  Post? _post;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    if(widget.post!=null)
      _post=widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // MultiBlocProvider(providers: [
    //   // BlocProvider(create: (context) => di.sl<PostBloc>()..add(GetAllPostsEvent())),
    // ],
    //     child:

    return  SafeArea(
      child: Scaffold(
        bottomNavigationBar: Helper.buttonNavigation ,
        appBar: AppBarPageWidget(pageName: "Comments".tr,),
        floatingActionButton: _buildAvatarGlow(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body:_buildBody(),
        // BlocConsumer<PostBloc, PostState>(
        //   builder:_builderDetailsPostBlocState,
        //   listener:_listenerDetailsPostBlocState,
        // ),
      ),
      // ),
    );
  }
  Widget _builderDetailsPostBlocState(BuildContext context, PostState state) {

    if (state is LoadingPostsState) {
      return const Center(child: CupertinoActivityIndicator());
    }
    if (state is ErrorPostCommentState) {
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else if (state is LoadedDetailsPostState) {
      Get.back();
      // if(_post==null){
      setState(() {
        _post=state.post;
      });
      // }

      return   _buildRefreshIndicatorWidget(context);
    }

    return   _buildRefreshIndicatorWidget(context);

    // if (state is LikeUnLikePostSuccessState) {
    //   Get.back();
    //   return _buildRefreshIndicatorWidget(context);
    // }

  }

  Widget _buildRefreshIndicatorWidget(BuildContext context){
    if (_post==null) {
      return Center(
          child: Container(
            child: Text("No Thing!!".tr,
              style: AppTextStyles.getTitleStyle(color: Colors.black),),
          ));
    }else {
      return RefreshIndicator(
        key: _refreshIndicatorKey,

        onRefresh: () async {
          BlocProvider.of<PostBloc>(context).add(GetPostEvent(postId: _post!.id!));
        },
        child: _buildBody(),
      );
    }
  }
  Widget _buildAvatarGlow() {
    return AvatarGlow(
      endRadius: 80,
      animate: false,
      glowColor: Colors.teal,
      child: FloatingActionButton(
        onPressed: ()async =>onAddComment(context),
        backgroundColor:  AppColor.primaryDarkColor,
        child: Icon(
          Icons.add ,
          color: AppColor.primaryIconColor, size: 35,),
      ),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.primaryAppBarColor,);
  }
  Widget _buildBody() {
    return  SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            PostWidget(post:_post!),
            Expanded(
              flex: 0,
              child: Container(
                color: AppColor.opacitybgCololr,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return CommentWidget(baseContext: this.context,comment: _post!.comments![index]) ;//
                  },
                  itemCount: _post!.comments!.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  void _listenerDetailsPostBlocState(BuildContext context, PostState state) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _refreshIndicatorKey.currentState?.show();
    // });
    if(state is LoadingPostsCommentsState){
      MessageBox.showDialog(context,textBody: WAIT_MESSAGE);
    }
    if(state is ErrorPostCommentState){
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else  if(state is LikeUnLikeSuccessState){
      MessageBox.showSuccess(context, "Succss");
      Get.back();
      // setState(() {
      //  state.userLiked!;
      // });
    }
  }
  void onAddComment(BuildContext context)async{
    await Get.to(AddUpdateCommentPage(
        isUpdate: false,
        comment:Comment(postId:_post!.id),
        onComplated: (_context,content){
          // SnackBarBuilder.ShowSuccess(context: context ,message:"state.message");
        }
    ));
  }

}
