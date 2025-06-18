import 'package:flutter/material.dart';

import '../domain/details_screen_argument/details_screen_argument.dart';
import 'pages/home_page.dart';
import 'pages/repo_details_page.dart';
import 'pages/splash_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings? settings) {
    final args = settings?.arguments;
    switch (settings?.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case 'details':
      final data = args as DetailsScreenArgument;
        return MaterialPageRoute(builder: (_) => RepositoryDetailsPage(argument: data));
      case 'splash':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: SafeArea(child: Center(child: Text('Unknown Route'))),
              ),
        );
    }
  }
}
