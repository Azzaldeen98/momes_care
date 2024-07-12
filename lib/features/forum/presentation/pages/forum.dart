//
//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:moms_care/core/constants/enam/forum_pages.dart';
// import 'package:moms_care/features/forum/presentation/bloc/post/comment_bloc.dart';
// import '../bloc/post/add_delete_update_comment_state.dart';
// import '/injection_container.dart' as di;
//
// class ForumPage extends StatefulWidget {
//   const ForumPage({Key? key, this.pagePost = PagePost.INDEX_PAGE})
//       : super(key: key);
//
//   final PagePost pagePost;
//   @override
//   State<ForumPage> createState() => _ForumPageState();
// }
//
// class _ForumPageState extends State<ForumPage> {
//
//   @override
//   void initState() {
//     pagePost = widget.pagePost;
//     super.initState();
//   }
//
//    PagePost? pagePost;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => di.sl<PostBloc>(),
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
//         body:
//         BlocConsumer<PostBloc, PostState>(
//           builder: _builderBlocState,
//           listener: _listenerSignInBlocState,
//
//         ),
//       ),
//     );
//   }
//
// }