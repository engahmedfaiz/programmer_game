import 'package:flutter/material.dart';
import '../models/code_challenge.dart';
import 'code_block_widget.dart';

class SolutionArea extends StatelessWidget {
  final List<CodeBlock> selectedBlocks;
  final Function(int) onRemoveBlock;
  final VoidCallback onExecute;
  final VoidCallback onClear;
  final String currentOutput;
  final bool isExecuting;

  const SolutionArea({
    super.key,
    required this.selectedBlocks,
    required this.onRemoveBlock,
    required this.onExecute,
    required this.onClear,
    required this.currentOutput,
    this.isExecuting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView( // 🔥 عشان يمنع overflow في العمود
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.build,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded( // 🔥 يحل مشكلة overflow لليمين
                  child: Text(
                    'منطقة بناء الكود',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Code blocks area
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: selectedBlocks.isEmpty
                  ? Column(
                children: [
                  Icon(
                    Icons.code_off,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اسحب كتل الكود هنا لبناء الحل',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
                  : Column(
                children: selectedBlocks.asMap().entries.map((entry) {
                  int index = entry.key;
                  CodeBlock block = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CodeBlockWidget(
                            codeBlock: block,
                            isInSolution: true,
                          ),
                        ),
                        IconButton(
                          onPressed: isExecuting
                              ? null
                              : () => onRemoveBlock(index),
                          icon: const Icon(Icons.close),
                          color: Colors.red[400],
                          iconSize: 20,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                    selectedBlocks.isEmpty || isExecuting ? null : onExecute,
                    icon: isExecuting
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Icon(Icons.play_arrow),
                    label: Text(isExecuting ? 'جاري التنفيذ...' : 'تشغيل الكود'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded( // 🔥 يحل مشكلة overflow للأزرار
                  child: ElevatedButton.icon(
                    onPressed: isExecuting ? null : onClear,
                    icon: const Icon(Icons.clear_all),
                    label: const Text('مسح الكل',style: TextStyle(),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Output area
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[600]!),
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
                      const SizedBox(width: 8),
                      Text(
                        'النتيجة:',
                        style: TextStyle(
                          color: Colors.green[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 60),
                    child: Text(
                      currentOutput.isEmpty
                          ? 'لا توجد نتيجة بعد...'
                          : currentOutput,
                      style: TextStyle(
                        color: currentOutput.isEmpty
                            ? Colors.grey[500]
                            : Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
