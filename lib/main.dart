import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ToxicodeGamesApp());
}

class ToxicodeGamesApp extends StatelessWidget {
  const ToxicodeGamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toxicode Games - منصة تعليم البرمجة',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // Green color similar to toxicode
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

