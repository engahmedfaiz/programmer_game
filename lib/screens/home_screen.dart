import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';
import '../widgets/app_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final availableGames = Game.getAvailableGames();
    final comingSoonGames = Game.getComingSoonGames();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(),
              
              // Hero Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      Theme.of(context).primaryColor.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.code,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'تعلم البرمجة!',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'هدفنا: تصميم أدوات ممتعة لتعريف المبتدئين بالبرمجة، أو لإتقان ممارسة المبرمجين، سواء كانوا أطفالاً أو بالغين.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Available Games Section
              if (availableGames.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.games,
                            color: Theme.of(context).primaryColor,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ألعابنا المتاحة',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.5 : 1.2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: availableGames.length,
                        itemBuilder: (context, index) {
                          return GameCard(game: availableGames[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ],

              // Coming Soon Games Section
              if (comingSoonGames.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.orange,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'قريباً',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.5 : 1.2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: comingSoonGames.length,
                        itemBuilder: (context, index) {
                          return GameCard(game: comingSoonGames[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ],

              // Footer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Text(
                      'منصة تعليم البرمجة التفاعلية',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'تعلم البرمجة بطريقة ممتعة وتفاعلية من خلال الألعاب والتحديات',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

