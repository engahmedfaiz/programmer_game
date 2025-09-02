import 'package:flutter/material.dart';
import '../models/dot_level.dart';

class LevelHeader extends StatelessWidget {
  final DotLevel level;
  final int currentMoves;
  final bool showHint;
  final VoidCallback onHintToggle;

  const LevelHeader({
    super.key,
    required this.level,
    required this.currentMoves,
    required this.showHint,
    required this.onHintToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المستوى ${level.id}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      level.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getMoveCountColor(context),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'الحركات: $currentMoves/${level.maxMoves}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Text(
            level.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[700],
            ),
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[600], size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'استخدم الأوامر لتحريك النقطة الزرقاء إلى الهدف الأخضر',
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: onHintToggle,
                icon: Icon(showHint ? Icons.lightbulb : Icons.lightbulb_outline),
                label: Text(showHint ? 'إخفاء التلميح' : 'تلميح'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          
          if (showHint) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.amber[600], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      level.hint,
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getMoveCountColor(BuildContext context) {
    double ratio = currentMoves / level.maxMoves;
    if (ratio <= 0.5) {
      return Colors.green;
    } else if (ratio <= 0.8) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

