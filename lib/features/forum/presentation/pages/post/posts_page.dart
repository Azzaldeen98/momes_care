import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/config/theme/text_style.dart';
import 'package:moms_care/core/constants/enam/forum_pages.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_bloc.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_event.dart';
import '../../../../../core/utils/dailog/message/message_box.dart';
import '../../../../../core/widget/navigation_bar/bottom_navigation_bar.dart';
import '../../../domain/entities/Post.dart';
import '../../bloc/post/post_state.dart';
import '/injection_container.dart' as di;

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key})
      : super(key: key);
  // final PagePost pagePost;
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  @override
  void initState() {
    // pagePost = widget.pagePost;
    super.initState();
  }
  // PagePost? pagePost;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => di.sl<PostBloc>()..add(GetAllPostsEvent()),
      child: Scaffold(
        bottomNavigationBar:AppBottomNavigationBar(),
        backgroundColor: const Color.fromRGBO(215, 212, 212, 1.0),
        body: BlocConsumer<PostBloc, PostState>(
          builder: _builderPostsPageBlocState,
          listener: _listenerPostsPageBlocState,
        ),
      ),
    );
  }

  void _listenerPostsPageBlocState(BuildContext context, PostState state) {
    if(state is ErrorPostsState){
      Get.back();
      MessageBox.showError(context, state.message);
    }else  if(state is LoadedPostsState){
      Get.back();
      // MessageBox.showSuccess(context, "Loaded Posts");
    }
  }

  Widget _builderPostsPageBlocState(BuildContext context, PostState state) {

    if (state is LoadingPostsState) {
      print("LoadedPostsState");
      return const Center(child: CupertinoActivityIndicator());
    }
    if (state is LoadedPostsState) {
      return ListView.builder(
        itemBuilder: (context,index){
          return PostWidget(
            post: state.posts![index] ,
            onPressed: (post){

            },
          );
        },
        itemCount: state.posts!.length,
      );

    }
    return Center(child: Container(child: Text("Empty Posts !!",
      style: AppTextStyles.getTitleStyle(color: Colors.black),),));
  }

  Widget PostWidget({ required Post post,required Function(Post post) onPressed}) {

    return  Container(
      padding: EdgeInsets.all(10),
       decoration: BoxDecoration(
           border: Border.all(),
           borderRadius: BorderRadius.circular(10)),
      child: Text(post.title!),
    );
  }

}

