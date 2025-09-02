import 'package:flutter/material.dart';
import 'models/level.dart';
import 'data/levels_data.dart';
import 'widgets/game_header.dart';
import 'widgets/challenge_widget.dart';
import 'widgets/game_complete_widget.dart';
import 'services/sound_service.dart';

void main() {
  runApp(const SilentTeacherApp());
}

class SilentTeacherApp extends StatelessWidget {
  const SilentTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silent Teacher - تعلم البرمجة بالاكتشاف',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentLevelId = 1;
  int _score = 0;
  bool _gameComplete = false;
  bool _showHint = false;
  int _attempts = 0;

  Level? get _currentLevel => LevelsData.getLevel(_currentLevelId);
  int get _totalLevels => LevelsData.totalLevels;

  void _handleAnswer(bool isCorrect, String userAnswer) {
    setState(() {
      _attempts++;
    });

    if (isCorrect) {
      // حساب النقاط بناءً على عدد المحاولات
      final points = (10 - _attempts).clamp(1, 10);
      setState(() {
        _score += points;
      });

      // الانتقال للمستوى التالي أو إنهاء اللعبة
      Future.delayed(const Duration(seconds: 2), () {
        if (_currentLevelId < _totalLevels) {
          setState(() {
            _currentLevelId++;
            _showHint = false;
            _attempts = 0;
          });
        } else {
          setState(() {
            _gameComplete = true;
          });
        }
      });
    }
  }

  void _handleHintRequest() {
    SoundService().playHint();
    setState(() {
      _showHint = true;
      // خصم نقطة واحدة عند طلب التلميح
      _score = (_score - 1).clamp(0, double.infinity).toInt();
    });
  }

  void _handleRestart() {
    setState(() {
      _currentLevelId = 1;
      _score = 0;
      _gameComplete = false;
      _showHint = false;
      _attempts = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameComplete) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: GameCompleteWidget(
              score: _score,
              totalLevels: _totalLevels,
              onRestart: _handleRestart,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GameHeader(
                currentLevel: _currentLevelId,
                totalLevels: _totalLevels,
                score: _score,
              ),
              if (_currentLevel != null)
                ChallengeWidget(
                  level: _currentLevel!,
                  onAnswer: _handleAnswer,
                  showHint: _showHint,
                  onHintRequest: _handleHintRequest,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
