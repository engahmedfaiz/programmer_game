import 'package:flutter/material.dart';
import '../models/game.dart';
import '../screens/game_screen.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: game.isAvailable
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(game: game),
                  ),
                );
              }
            : null,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Game Image/Icon
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: game.isAvailable 
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getGameIcon(game.id),
                    size: 48,
                    color: game.isAvailable 
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Game Title
              Text(
                game.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: game.isAvailable ? null : Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 4),
              
              // Category and Difficulty
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: game.isAvailable 
                          ? Theme.of(context).primaryColor.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      game.category,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: game.isAvailable 
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < game.difficulty ? Icons.star : Icons.star_border,
                        size: 16,
                        color: game.isAvailable ? Colors.amber : Colors.grey,
                      );
                    }),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Description
              Expanded(
                flex: 2,
                child: Text(
                  game.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: game.isAvailable ? Colors.grey[600] : Colors.grey,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Concepts Tags
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: game.concepts.take(3).map((concept) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: game.isAvailable 
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      concept,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: game.isAvailable ? Colors.blue : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 12),
              
              // Play Button or Coming Soon
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: game.isAvailable
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameScreen(game: game),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: game.isAvailable 
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    game.isAvailable ? 'العب الآن' : game.comingSoonMessage ?? 'قريباً',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getGameIcon(String gameId) {
    switch (gameId) {
      case 'silent_teacher':
        return Icons.school;
      case 'compute_it':
        return Icons.computer;
      case 'code_n_slash':
        return Icons.videogame_asset;
      case 'utopian_architect':
        return Icons.architecture;
      case 'paint_duel':
        return Icons.palette;
      case 'little_dot_adventure':
        return Icons.explore;
      default:
        return Icons.games;
    }
  }
}

