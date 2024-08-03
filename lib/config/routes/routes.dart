import 'package:flutter/material.dart';
import 'package:moms_care/features/home/persention/pages/home_page.dart';
import 'routes_name.dart';


class AppRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return _materialRoute(const HomePage());
      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (BuildContext context) => view);
  }
}
