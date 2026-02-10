import 'package:flutter/material.dart';
import 'router.dart';
import 'theme.dart';

class DIGApp extends StatelessWidget {
  const DIGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dev Interview Gym',
      theme: buildTheme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.home,
      debugShowCheckedModeBanner: false,
    );
  }
}
