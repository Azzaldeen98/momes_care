import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moms_care/core/constants/enam/app_pages.dart';
import 'package:moms_care/core/constants/messages.dart';
import 'package:moms_care/core/utils/dailog/message/message_snack_bar.dart';
import 'package:moms_care/core/widget/empty_widget.dart';
import 'package:moms_care/features/forum/domain/entities/Post.dart';
import 'package:moms_care/features/forum/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:moms_care/features/forum/presentation/bloc/posts/post_event.dart';
import 'package:moms_care/features/forum/presentation/pages/comment/comment_controll.dart';
import 'package:moms_care/features/forum/presentation/wedgits/pages/add_update_comment_widget.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';

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
import 'package:moms_care/injection_container.dart' as di;


class CommentsPage extends StatefulWidget {

  const CommentsPage({Key? key,required this.post}) : super(key: key);

  final Post post;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {

  final CommentsController controller = Get.put(CommentsController());
  // late Post? _post;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
 var post = Rx<Post?>(null);

  @override
  void initState() {
    super.initState();


    if(widget.post!=null) {
      print(widget.post!.title);
      // post.value=widget.post;
      // post.refresh();

      setState(() {
       // _post=widget.post;
        controller.updatePost(widget.post);
     });
    }

  }



  @override
  Widget build(BuildContext context) {

    return
      BlocProvider(
         create: (context) => di.sl<PostBloc>()..add(GetPostEvent(postId: controller!.post.value!.id??0)),
         child:
         SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: Helper.buttonNavigation ,
              appBar: AppBarPageWidget(pageName: "Comments".tr,actions: [
                IconButton(
                onPressed:() async{
                  Get.offAll(HomePage(numberScreen:AppPages.FORUM.index,));
                  await Future.delayed(Duration(seconds: 2));
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.white,),
              ),],),
              floatingActionButton: _buildAvatarGlow(),
              floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
              body:BlocConsumer<PostBloc, PostState>(
              builder:_builderCommentsBlocState,
              listener:_listenerCommentsBlocState,),
            ),
            ),
    );
  }

  Widget _builderCommentsBlocState(BuildContext context, PostState state) {

    if (state is LoadingPostsState) {
      return const Center(child: CupertinoActivityIndicator());
    }
    // if (state is ErrorPostCommentState) {
    //   Get.back();
    //   MessageBox.showError(context, state.message);
    // }
    else if (state is AddDeleteUpdateSuccessState) {

    }
    else if (state is LoadedDetailsPostState) {
      // Get.back();
      // post.value=state.post;
      print("LoadedDetailsPostState");
      if(state.post!=null)
        controller.updatePost(state.post);
      return   _buildRefreshIndicatorWidget(context);
    }
    else {
      print("NOLoadedDetailsPostState");
        return   _buildRefreshIndicatorWidget(context);
      }

    return EmptyWidget();

    // if (state is LikeUnLikePostSuccessState) {
    //   Get.back();
    //   return _buildRefreshIndicatorWidget(context);
    // }

  }

  Widget _buildRefreshIndicatorWidget(BuildContext context) {
    return (controller.post==null)? EmptyWidget(explanatoryText: "No Thing!!".tr)
        :  RefreshIndicator(
        key: _refreshIndicatorKey ,
        onRefresh: () async  {
          int postId=controller.post.value!.id!;
          BlocProvider.of<PostBloc>(context).add(GetPostEvent(postId:postId));
          await Future.delayed(const Duration(seconds: 2));
        },
        child: _buildBody()
    );
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return    ConstrainedBox(
              constraints: BoxConstraints(
                // minHeight: constraints.maxHeight,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child:Container(
                margin: EdgeInsets.all(10),
                child: Column(
                    children: [
                        Container(
                          // height: 350,
                            child: PostWidget(post:controller.post.value!)
                        ),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            color: AppColor.secondColor,
                            padding: EdgeInsets.symmetric(horizontal:30 ,vertical: 20),
                            child: Text("# "+"Comments".tr,style: AppTextStyles.getTitleStyle(color: AppColor.secondDarkColor),),
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                        Container(
                            // color: AppColor.opacitybgCololr,
                          decoration: BoxDecoration(
                            boxShadow: [
                              const BoxShadow(
                                color: AppColor.secondColor,
                              ),
                              const BoxShadow(
                                color: AppColor.secondColor,
                                spreadRadius: -5.0,
                                blurRadius: 5.0,
                              ),
                            ],
                              borderRadius: BorderRadius.circular(10)
                          ),
                            padding: EdgeInsets.all(0),
                            child:Column(
                              children: [
                                (controller.post.value!.comments!=null
                                    && controller.post.value!.comments!.isNotEmpty)
                                    ? ListView.builder(
                                  reverse: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    return CommentWidget(baseContext:this.context,comment: controller.post.value!.comments![index]);
                                  },
                                  itemCount: controller.post.value!.comments!.length,
                                )
                                    : SizedBox(),
                              ],
                            )
                          ),
                      ],
                ),
              ),
          );

            // ConstrainedBox(
            //   constraints: BoxConstraints(
            //     minHeight: MediaQuery.of(context).size.height,
            //   ),
            // child: ,
          // );
        }
      ),
    );

  }

  void _listenerCommentsBlocState(BuildContext context, PostState state) {

    // if(state is LoadingDetailsPostState){
    //   MessageBox.showProgress(context, WAIT_MESSAGE);
    // }
    if(state is ErrorPostCommentState){
      Get.back();
      MessageBox.showError(context, state.message);
    }
    else  if(state is LoadedDetailsPostState){
      // Get.back();
        setState(() async{
          controller.updatePost(state.post);
          // post.refresh();
        });

    }
    else  if(state is AddDeleteUpdateSuccessState){
      Get.back();
      SnackBarBuilder.ShowSuccess(context: context, message: state.message);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshIndicatorKey.currentState?.show();
      });
    }
    else  if(state is LikeUnLikeSuccessState){
      // MessageBox.showSuccess(context, "Succss");
      Get.back();
      // setState(() {
      //  state.userLiked!;
      // });
    }
  }
  void onAddComment(BuildContext context)async{
    await Get.to(AddUpdateCommentPage(
        isUpdate: false,
        comment:Comment(postId:controller.post.value!.id),
        onComplated: (_context,content){
          // SnackBarBuilder.ShowSuccess(context: context ,message:"state.message");
        }
    ));
  }

}


class InnerShadowContainer extends StatelessWidget {
final Widget child;
final double width;
final double height;

InnerShadowContainer({
  required this.child,
  this.width = double.infinity,
  this.height = double.infinity,
});

@override
Widget build(BuildContext context) {
  return Container(
    // width: width,
    // height: height,
    decoration: BoxDecoration(
      color: Colors.white, // Color of the container
    ),
    child: CustomPaint(
      painter: InnerShadowPainter(),
      child: child,
    ),
  );
}
}

class InnerShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0); // Blur effect
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(10));
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}