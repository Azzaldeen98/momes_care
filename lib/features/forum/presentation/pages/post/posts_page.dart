import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/constants/enam/forum_pages.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/forum/presentation/wedgits/pages/add_update_comment_widget.dart';
// import 'package:nb_utils/nb_utils.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/color_app.dart';
import '../../../../../config/theme/font_manager.dart';
import '../../../../../core/utils/dailog/message/message_box.dart';
import '../../../../../core/widget/bottom_sheets/bottom_sheet.dart';
import '../../../../../core/widget/label/text_widget.dart';
import '../../../../../core/widget/navigation_bar/bottom_navigation_bar.dart';
import '../../../../../helpers/public_infromation.dart';
import '../../../domain/entities/Post.dart';
import '../../bloc/posts/post_state.dart';
import '../../wedgits/pages/add_update_post_widget.dart';
import '../../wedgits/posts/post_widget.dart';
import '/injection_container.dart' as di;

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key})
      : super(key: key);
  // final PagePost pagePost;
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  List<Post>? _listPost;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // pagePost = widget.pagePost;
    super.initState();
  }
  // PagePost? pagePost;

  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(providers: [
      BlocProvider(create: (context) => di.sl<PostBloc>()..add(GetAllPostsEvent())),
    ],
      child: SafeArea(
        child: Scaffold(
          // bottomNavigationBar: Helper.buttonNavigation ,
          backgroundColor: const Color.fromRGBO(215, 212, 212, 1.0),
          floatingActionButton: AvatarGlow(
          endRadius: 80,
          // animate: isListening,
          glowColor: Colors.teal,
            child: FloatingActionButton(
            child: Icon(Icons.add ,color: AppColor.whiteColor, size: 35,),
            backgroundColor: AppColor.primaryColor,
           onPressed: () async{
              // MessageBox.showDialog(context,textBody: "message");
             await Get.to(const AddUpdatePostPage(isUpdatePost: false,));
           }),
            // showCustomBottomSheet(context: context,child: AddUpdatePostPage(
            //   isUpdatePost: false,
          //     onClickSaved:(title,content) async{
          //       BlocProvider.of<PostBloc>(context).add(AddPostEvent(title: title,content:content));
          //     },onCreatedOrUpdatedIsSuccess: (){
          //     print("onCreatedOrUpdatedIsSuccess");
          //     WidgetsBinding.instance.addPostFrameCallback((_) {
          //       _refreshIndicatorKey.currentState?.show();
          //     });
          //         // MessageBox.showSuccess(context, " succussfly ");
          //         // Get.back();
          //   },baseContext: context,));
          // },

        // ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
          body: BlocConsumer<PostBloc, PostState>(
            builder: _builderPostsPageBlocState,
            listener: _listenerPostsPageBlocState,
          ),
        ),
      ),
    );
  }
  void _listenerPostsPageBlocState(BuildContext context, PostState state) {
    if(state is LoadingPostsState){
      print("LoadedPostsState99");
      // MessageBox.showProgress(context, "wait..");
    }
    if(state is ErrorPostsState){
      Get.back();
      MessageBox.showError(context, state.message);
    }else  if(state is LoadedPostsState){
      Get.back();
      _listPost=state.posts;
      //
    } else if (state is DeletedPostSuccessState) {
        print("DeletedPostSuccessState 878");
      // toast("Delete Post is Successfully !! ");
    }
   else  if (state is AddPostSuccessState) {

      MessageBox.showSuccess(context, "add succussfly");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _refreshIndicatorKey.currentState?.show();
      });

    }
  }
  Widget _builderPostsPageBlocState(BuildContext context, PostState state) {

    if (state is LoadingPostsState) {
      print("LoadedPostsState");
      return const Center(child: CupertinoActivityIndicator());
    }
    if (state is LoadedPostsState) {
      if(_listPost==null)
          _listPost=state.posts;
      return   _buildRefreshIndicatorWidget(context);

    }
    if (state is LikeUnLikePostSuccessState) {
      return _buildRefreshIndicatorWidget(context);
    }

    return   _buildRefreshIndicatorWidget(context);

  }
  Widget _buildRefreshIndicatorWidget(BuildContext context){
    return (_listPost==null) ?  Center(child: Container(child: Text("Empty Posts !!",
      style: AppTextStyles.getTitleStyle(color: Colors.black),),))
        :  RefreshIndicator(
            key: _refreshIndicatorKey ,
            onRefresh: () async  {
              BlocProvider.of<PostBloc>(context).add(GetAllPostsEvent());
            },
            child: ListView.builder(
              itemBuilder: (context,index){
                return PostWidget(post: _listPost![index]);
              },
              itemCount: _listPost!.length,
            ),
    );
  }


}

