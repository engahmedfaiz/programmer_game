import 'package:flutter/material.dart';
import '../models/game.dart';
import '../games/silent_teacher/silent_teacher_game.dart';
import '../games/little_dot_adventure/little_dot_adventure_game.dart';
import '../games/code_builder/code_builder_game.dart';
import '../games/compute_it/compute_it_game.dart';
import '../games/code_n_slash/code_n_slash_game.dart';
import '../games/utopian_architect/utopian_architect_game.dart';
import '../games/paint_duel/paint_duel_game.dart';

class GameScreen extends StatelessWidget {
  final Game game;

  const GameScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildGameContent(context),
    );
  }

  Widget _buildGameContent(BuildContext context) {
    switch (game.id) {
      case 'silent_teacher':
        return const SilentTeacherGame();
      case 'little_dot_adventure':
        return const LittleDotAdventureGame();
      case 'code_builder':
        return const CodeBuilderGame();
      case 'compute_it':
        return const ComputeItGame();
      case 'code_n_slash':
        return const CodeNSlashGame();
      case 'utopian_architect':
        return const UtopianArchitectGame();
      case 'paint_duel':
        return const PaintDuelGame();
      default:
        return _buildComingSoonContent(context, game.title);
    }
  }

  Widget _buildComingSoonContent(BuildContext context, String gameName) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            Text(
              'قريباً!',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'لعبة $gameName تحت التطوير حالياً',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'سنقوم بإضافتها قريباً مع المزيد من الألعاب التعليمية الممتعة!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'العودة للصفحة الرئيسية',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

