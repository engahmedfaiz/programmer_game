import 'package:flutter/material.dart';
import '../models/compute_challenge.dart';

class CodeDisplay extends StatelessWidget {
  final String code;
  final int currentStep;
  final List<ComputeStep> steps;

  const CodeDisplay({
    super.key,
    required this.code,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.code,
                color: Colors.green[400],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'الكود المراد تنفيذه:',
                style: TextStyle(
                  color: Colors.green[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildCodeLines(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCodeLines() {
    List<String> lines = code.split('\n');
    List<Widget> widgets = [];

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];
      bool isCurrentLine = _isCurrentStepLine(line, i);
      bool isCompletedLine = _isCompletedStepLine(line, i);

      widgets.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          margin: const EdgeInsets.symmetric(vertical: 1),
          decoration: BoxDecoration(
            color: isCurrentLine 
                ? Colors.yellow[700]?.withOpacity(0.3)
                : isCompletedLine 
                    ? Colors.green[700]?.withOpacity(0.2)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: isCurrentLine 
                ? Border.all(color: Colors.yellow[600]!, width: 2)
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (isCurrentLine)
                Icon(
                  Icons.play_arrow,
                  color: Colors.yellow[600],
                  size: 16,
                ),
              if (isCompletedLine && !isCurrentLine)
                Icon(
                  Icons.check,
                  color: Colors.green[400],
                  size: 16,
                ),
              if (!isCurrentLine && !isCompletedLine)
                const SizedBox(width: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  line,
                  style: TextStyle(
                    color: isCurrentLine 
                        ? Colors.yellow[100]
                        : isCompletedLine 
                            ? Colors.green[100]
                            : Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: isCurrentLine ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  bool _isCurrentStepLine(String line, int lineIndex) {
    if (currentStep >= steps.length) return false;
    
    ComputeStep step = steps[currentStep];
    String stepCode = step.codeSnippet.split('#')[0].trim();
    String cleanLine = line.trim();
    
    return cleanLine.contains(stepCode) || stepCode.contains(cleanLine);
  }

  bool _isCompletedStepLine(String line, int lineIndex) {
    String cleanLine = line.trim();
    if (cleanLine.isEmpty) return false;

    for (int i = 0; i < currentStep && i < steps.length; i++) {
      ComputeStep step = steps[i];
      String stepCode = step.codeSnippet.split('#')[0].trim();
      
      if (cleanLine.contains(stepCode) || stepCode.contains(cleanLine)) {
        return true;
      }
    }
    
    return false;
  }
}

