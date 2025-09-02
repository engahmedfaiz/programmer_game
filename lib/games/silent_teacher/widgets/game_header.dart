import 'package:flutter/material.dart';
import '../services/sound_service.dart';

class GameHeader extends StatefulWidget {
  final int currentLevel;
  final int totalLevels;
  final int score;

  const GameHeader({
    super.key,
    required this.currentLevel,
    required this.totalLevels,
    required this.score,
  });

  @override
  State<GameHeader> createState() => _GameHeaderState();
}

class _GameHeaderState extends State<GameHeader> {

  @override
  Widget build(BuildContext context) {
    final progressPercentage = (widget.currentLevel / widget.totalLevels);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // العنوان والنقاط
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Silent Teacher',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                children: [
                  // زر تشغيل/إيقاف الصوت
                  IconButton(
                    onPressed: () {
                      setState(() {
                        SoundService().toggleSound();
                      });
                    },
                    icon: Icon(
                      SoundService().soundEnabled 
                          ? Icons.volume_up 
                          : Icons.volume_off,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'النقاط: ${widget.score}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // شريط التقدم
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المستوى ${widget.currentLevel} من ${widget.totalLevels}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '${(progressPercentage * 100).round()}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progressPercentage,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // الوصف
          Text(
            'اكتشف القواعد من خلال التجربة - لا توجد تعليمات صريحة!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

