import 'package:flutter/material.dart';
import '../features/quiz/presentation/screens/home_screen.dart';
import '../features/quiz/presentation/screens/quiz_screen.dart';
import '../features/progress/presentation/screens/favorites_screen.dart';
import '../features/progress/presentation/screens/retry_screen.dart';

class AppRoutes {
  static const home = '/';
  static const quiz = '/quiz';
  static const favorites = '/favorites';
  static const retry = '/retry';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.quiz:
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case AppRoutes.retry:
        return MaterialPageRoute(builder: (_) => const RetryScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
