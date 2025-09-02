import 'package:flutter/material.dart';

class GameCompleteWidget extends StatelessWidget {
  final int score;
  final int totalLevels;
  final VoidCallback onRestart;

  const GameCompleteWidget({
    super.key,
    required this.score,
    required this.totalLevels,
    required this.onRestart,
  });

  Map<String, dynamic> _getPerformanceData() {
    final percentage = (score / (totalLevels * 10)) * 100;
    
    if (percentage >= 90) {
      return {
        'message': 'أداء ممتاز! أنت محترف في اكتشاف الأنماط!',
        'stars': 3,
        'color': Colors.amber,
      };
    } else if (percentage >= 70) {
      return {
        'message': 'أداء جيد جداً! تحسنت كثيراً في فهم الأنماط.',
        'stars': 2,
        'color': Colors.blue,
      };
    } else {
      return {
        'message': 'أداء جيد! استمر في التدريب لتحسين مهاراتك.',
        'stars': 1,
        'color': Colors.green,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final performance = _getPerformanceData();
    final successRate = ((score / (totalLevels * 10)) * 100).round();

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // أيقونة الكأس
            const Icon(
              Icons.emoji_events,
              size: 80,
              color: Colors.amber,
            ),
            
            const SizedBox(height: 16),
            
            // عنوان التهنئة
            Text(
              'تهانينا!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'لقد أكملت جميع التحديات',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // النتيجة النهائية
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    '$score نقطة',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'من أصل ${totalLevels * 10} نقطة',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // تقييم الأداء بالنجوم
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Icon(
                  index < performance['stars'] ? Icons.star : Icons.star_outline,
                  size: 36,
                  color: performance['color'],
                );
              }),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              performance['message'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: performance['color'],
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // إحصائيات
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'المستويات المكتملة',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalLevels',
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'معدل النجاح',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$successRate%',
                          style: TextStyle(
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // زر إعادة اللعب
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRestart,
                icon: const Icon(Icons.refresh),
                label: const Text('العب مرة أخرى'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              'شكراً لك على اللعب! استمر في تعلم البرمجة.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

