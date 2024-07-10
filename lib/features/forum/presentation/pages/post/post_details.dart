import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/utils/dailog/toast/toast_box.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/features/forum/presentation/bloc/post/post_event.dart';

import '../../../../../config/theme/color_app.dart';
import '../../../../../config/theme/text_style.dart';
import '../../../../../core/utils/dailog/message/message_box.dart';
import '../../../domain/entities/Comment.dart';
import '../../bloc/post/post_bloc.dart';
import '../../bloc/post/post_state.dart';
import '../../wedgits/comment_card_view_widget.dart';
import '../../wedgits/post_card_widget.dart';
import '/injection_container.dart' as di;

class PostsDetails extends StatefulWidget {
  final Post post;
  const PostsDetails({Key? key,required this.post})
      : super(key: key);

  @override
  State<PostsDetails> createState() => _PostsDetailsState();
}

class _PostsDetailsState extends State<PostsDetails> {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (_) => di.sl<PostBloc>(), //..add()),
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios))
        ],),
        backgroundColor: const Color.fromRGBO(215, 212, 212, 1.0),
        body:_builderDetailsPostBlocState()
        // BlocConsumer<PostBloc, PostState>(
        //   builder: _builderDetailsPostBlocState,
        //   listener: _listenerDetailsPostBlocState,
        ),
      // ),
    );

  }

  Widget _builderDetailsPostBlocState() {

    print("CommentCardViewWidget:${widget.post!.comments!.length}");
    return Container(

      child: Column(
        children: [
          PostCardWidget(post:widget.post),
          SizedBox(height: 0,),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              color: Colors.grey,
              child: ListView.builder(
                itemBuilder: (context,index){
                  return  ListTile(title:CommentCardViewWidget(comment: widget.post!.comments![index]) ,);//
                },
                itemCount: widget.post!.comments!.length,
              ),
            ),
          ),
            ],
      ),
    );
    // if (state is LoadingDetailsPostsState) {
    //   print("LoadedPostsState9");
    //   return const Center(child: CupertinoActivityIndicator());
    // }
    // if (state is LoadedDetailsPostState) {
    //   return Container(
    //     child: Column(
    //       children: [
    //         PostCardWidget(post:state.post),
    //         SizedBox(height: 10,),
    //         ListView.builder(
    //           itemBuilder: (context,index){
    //             return CommentCardViewWidget(comment: state.post!.comments![index]);
    //           },
    //           itemCount: state.post!.comments!.length,
    //         ),
    //       ],
    //     ),
    //   );
    // }
    // return Center(child: Container(child: Text("Empty Comments !!",
    //   style: AppTextStyles.getTitleStyle(color: Colors.black),),));
  }

  void _listenerDetailsPostBlocState(BuildContext context, PostState state) {

    if(state is ErrorPostsState){
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else  if(state is LoadedDetailsPostState){
      Get.back();
    }

  }
}