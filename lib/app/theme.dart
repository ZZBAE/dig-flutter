import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
