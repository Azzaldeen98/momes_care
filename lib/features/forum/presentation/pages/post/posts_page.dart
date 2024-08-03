import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/core/utils/theme/app_color.dart';
import 'package:moms_care/core/utils/dailog/message/message_box.dart';
import 'package:moms_care/core/widget/app_bar/app_bar_page_view_widget.dart';
import 'package:moms_care/core/helpers/public_infromation.dart';
import '../../../domain/entities/Post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_state.dart';
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
      child: Scaffold(
        appBar: AppBarPageWidget(pageName: "Forum".tr,),
        bottomNavigationBar: Helper.buttonNavigation ,
        backgroundColor: const Color.fromRGBO(215, 212, 212, 1.0),
        floatingActionButton: _buildAvatarGlow(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: BlocConsumer<PostBloc, PostState>(
          builder: _builderPostsPageBlocState,
          listener: _listenerPostsPageBlocState,
        ),
      ),
    );
  }
  Widget _builderPostsPageBlocState(BuildContext context, PostState state) {

    if (state is LoadingPostsState) {
      return const Center(child: CupertinoActivityIndicator());
    }
    if (state is LoadedPostsState) {

      if(state.posts!=null)
          _listPost=state.posts;

      return   _buildRefreshIndicatorWidget(context);

    }
    if (state is LikeUnLikePostSuccessState) {
      return _buildRefreshIndicatorWidget(context);
    }
    return   _buildRefreshIndicatorWidget(context);
  }
  Widget _buildRefreshIndicatorWidget(BuildContext context){

    if(_listPost==null)
      _listPost=List<Post>.empty();

    return (_listPost==null) ?  EmptyWidget(explanatoryText:"EmptyPosts".tr,)
        :  RefreshIndicator(
            key: _refreshIndicatorKey ,
            onRefresh: () async  {
              BlocProvider.of<PostBloc>(context).add(GetAllPostsEvent());
            },
            child: ListView.builder(
              itemBuilder: (context,index){
                print("POST:::${_listPost![index]}");
                return PostWidget(post: _listPost![index],onDelete: (){},);
              },
              itemCount:_listPost!.length,
            ),
    );
  }
  Widget _buildAvatarGlow(){
    return AvatarGlow(
      endRadius: 80,
      // animate: isListening,
      glowColor: Colors.teal,
      child: FloatingActionButton(
          child: Icon(Icons.add ,color: AppColor.whiteColor, size: 35,),
          backgroundColor: AppColor.primaryColor,
          onPressed:onAddPost),
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
    }
    else if(state is LoadedPostsState){
      Get.back();
      _listPost=state.posts;
      //
    }
    else if (state is AddDeleteUpdateSuccessState) {
      SnackBarBuilder.ShowSuccess(context: context, message: state.message);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshIndicatorKey.currentState?.show();
      });
    }

  }
  void onAddPost()async{
  await Get.to(const AddUpdatePostPage(isUpdatePost: false,));
}

}

