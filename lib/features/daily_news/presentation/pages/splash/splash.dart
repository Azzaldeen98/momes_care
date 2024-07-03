import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:moms_care/config/local/locale_controller.dart';
import 'package:moms_care/config/routes/routes_name.dart';
import 'package:moms_care/core/helpers/cache_helper.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:moms_care/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../domain/entities/article.dart';
import '../../widgets/article_tile.dart';

class SplashPage extends StatelessWidget {

  const SplashPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Align(
      alignment: Alignment.topLeft,  // and bottomLeft
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppbar(context),
          body: _buildBody() ,
        ),
      ),
    );

  }
  
  _buildAppbar(BuildContext context) {
    return AppBar(
      title:  Text(
          'Home'.tr,
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => _onShowSavedArticlesViewTapped(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.bookmark, color: Colors.black),
            ),
          ),
        ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc,RemoteArticlesState> (
      builder: (_,state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
           itemBuilder: (context,index){
            return ArticleWidget(
              article: state.articles![index] ,
              onArticlePressed: (article) => _onArticlePressed(context,article),
            );
           },
           itemCount: state.articles!.length,
         );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, RoutesName.articleDetails, arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.savedArticles);
  }
  
}