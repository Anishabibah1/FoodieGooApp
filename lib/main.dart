import 'package:flutter/material.dart';
import 'theme.dart';
import 'splash_screen.dart';

void main() {
  runApp(const FoodieGoApp());
}

class FoodieGoApp extends StatelessWidget {
  const FoodieGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodieGo',
      debugShowCheckedModeBanner: false,
      theme: foodieTheme(),
      home: const SplashScreen(),
    );
  }
}