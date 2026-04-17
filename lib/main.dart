import 'package:flutter/material.dart';
import 'home_page.dart'; // pastikan ini benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(), // 🔥 HARUS INI
      debugShowCheckedModeBanner: false,
    );
  }
}