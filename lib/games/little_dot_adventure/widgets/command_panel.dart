import 'package:flutter/material.dart';

class CommandPanel extends StatelessWidget {
  final List<String> availableCommands;
  final List<String> selectedCommands;
  final Function(String) onCommandSelected;
  final VoidCallback onExecute;
  final VoidCallback onReset;
  final bool isExecuting;

  const CommandPanel({
    super.key,
    required this.availableCommands,
    required this.selectedCommands,
    required this.onCommandSelected,
    required this.onExecute,
    required this.onReset,
    this.isExecuting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الأوامر المتاحة:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Available Commands
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availableCommands.map((command) {
              return ElevatedButton(
                onPressed: isExecuting ? null : () => onCommandSelected(command),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  foregroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
                child: Text(
                  command,
                  style: const TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'تسلسل الأوامر:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Selected Commands Display
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 100),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: selectedCommands.isEmpty
                ? Text(
                    'اختر الأوامر من الأعلى...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: selectedCommands.asMap().entries.map((entry) {
                      int index = entry.key;
                      String command = entry.value;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${index + 1}. $command',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: isExecuting ? null : () => _removeCommand(index),
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.red[400],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: selectedCommands.isEmpty || isExecuting ? null : onExecute,
                  icon: isExecuting 
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.play_arrow),
                  label: Text(isExecuting ? 'جاري التنفيذ...' : 'تنفيذ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: isExecuting ? null : onReset,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة تعيين'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _removeCommand(int index) {
    // This should be handled by the parent widget
    // For now, we'll just show a placeholder
  }
}

