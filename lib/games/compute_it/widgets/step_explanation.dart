import 'package:flutter/material.dart';
import '../models/compute_challenge.dart';
import '../data/compute_challenges_data.dart';

class StepExplanation extends StatelessWidget {
  final ComputeStep step;
  final bool isCompleted;

  const StepExplanation({
    super.key,
    required this.step,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted ? Colors.green[200]! : Colors.orange[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.green[600] : Colors.orange[600],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    ComputeChallengesData.getStepTypeIcon(step.type),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الخطوة ${step.stepNumber}',
                      style: TextStyle(
                        color: isCompleted ? Colors.green[800] : Colors.orange[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      ComputeChallengesData.getStepTypeDescription(step.type),
                      style: TextStyle(
                        color: isCompleted ? Colors.green[600] : Colors.orange[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Icon(
                  Icons.check_circle,
                  color: Colors.green[600],
                  size: 24,
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Instruction
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المطلوب:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.instruction,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Code snippet
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              step.codeSnippet,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
          
          if (isCompleted) ...[
            const SizedBox(height: 12),
            
            // Explanation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Colors.green[700],
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'الشرح:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.explanation,
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            // Output if any
            if (step.output != null) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.terminal,
                          color: Colors.green[400],
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'الإخراج:',
                          style: TextStyle(
                            color: Colors.green[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step.output!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

