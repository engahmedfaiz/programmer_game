import 'package:flutter/material.dart';
import '../models/level.dart';
import '../services/sound_service.dart';

class ChallengeWidget extends StatefulWidget {
  final Level level;
  final Function(bool, String) onAnswer;
  final bool showHint;
  final VoidCallback onHintRequest;

  const ChallengeWidget({
    super.key,
    required this.level,
    required this.onAnswer,
    required this.showHint,
    required this.onHintRequest,
  });

  @override
  State<ChallengeWidget> createState() => _ChallengeWidgetState();
}

class _ChallengeWidgetState extends State<ChallengeWidget> {
  final TextEditingController _controller = TextEditingController();
  String? _feedback;
  bool? _isCorrect;
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_controller.text.trim().isEmpty || _isProcessing) return;

    setState(() {
      _isProcessing = true;
      final userAnswer = _controller.text.trim();
      final correct = userAnswer.toLowerCase() == widget.level.expectedAnswer.toLowerCase();
      _isCorrect = correct;
      _feedback = correct ? widget.level.feedbackCorrect : widget.level.feedbackIncorrect;
      
      // تشغيل الصوت المناسب
      if (correct) {
        SoundService().playSuccess();
      } else {
        SoundService().playError();
      }
    });

    // تأخير لإظهار التغذية الراجعة
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        widget.onAnswer(_isCorrect!, _controller.text.trim());
        if (_isCorrect!) {
          _controller.clear();
          setState(() {
            _feedback = null;
            _isCorrect = null;
            _isProcessing = false;
          });
        } else {
          setState(() {
            _isProcessing = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // عنوان التحدي
            Text(
              'التحدي #${widget.level.id}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // عرض السؤال
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.level.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // إدخال الإجابة
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: 'أدخل إجابتك هنا...',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !_isProcessing,
                    onSubmitted: (_) => _handleSubmit(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('إرسال'),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // التغذية الراجعة
            if (_feedback != null) ...[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: _isCorrect! 
                      ? Colors.green[50] 
                      : Colors.red[50],
                  border: Border.all(
                    color: _isCorrect! 
                        ? Colors.green[200]! 
                        : Colors.red[200]!,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isCorrect! ? Icons.check_circle : Icons.error,
                      color: _isCorrect! ? Colors.green[700] : Colors.red[700],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _feedback!,
                        style: TextStyle(
                          color: _isCorrect! ? Colors.green[700] : Colors.red[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // زر التلميح
            if (!_isProcessing && _isCorrect != true && !widget.showHint) ...[
              Center(
                child: OutlinedButton.icon(
                  onPressed: widget.onHintRequest,
                  icon: const Icon(Icons.lightbulb_outline),
                  label: const Text('احتاج تلميح'),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // عرض التلميح
            if (widget.showHint) ...[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.yellow[50],
                  border: Border.all(color: Colors.yellow[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.yellow[700]),
                        const SizedBox(width: 8),
                        Text(
                          'تلميح:',
                          style: TextStyle(
                            color: Colors.yellow[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.level.hint,
                      style: TextStyle(color: Colors.yellow[600]),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

