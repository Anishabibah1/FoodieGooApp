import 'package:flutter/material.dart';
import 'shared/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const FoodieGooApp());
}

class FoodieGooApp extends StatelessWidget {
  const FoodieGooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodieGoo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const LoginPage(),
    );
  }
}