import 'package:flutter/material.dart';
import 'package:moms_care/features/moms_care/presentation/pages/home/home_page.dart';

import '../../features/daily_news/domain/entities/article.dart';
import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';
import '../../features/daily_news/presentation/pages/home/daily_news.dart';
import '../../features/daily_news/presentation/pages/saved_article/saved_article.dart';
import 'routes_name.dart';


class AppRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return _materialRoute(const HomePage());

      case RoutesName.articleDetails:
        return _materialRoute(ArticleDetailsView(article: settings.arguments as ArticleEntity));

      case RoutesName.savedArticles:
        return _materialRoute(const SavedArticles());
        
      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (BuildContext context) => view);
  }
}
