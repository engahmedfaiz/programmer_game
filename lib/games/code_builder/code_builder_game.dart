import 'package:flutter/material.dart';
import 'models/code_challenge.dart';
import 'data/code_challenges_data.dart';
import 'widgets/code_block_widget.dart';
import 'widgets/solution_area.dart';

class CodeBuilderGame extends StatefulWidget {
  const CodeBuilderGame({super.key});

  @override
  State<CodeBuilderGame> createState() => _CodeBuilderGameState();
}

class _CodeBuilderGameState extends State<CodeBuilderGame> {
  int _currentChallengeId = 1;
  CodeBuilderState _gameState = const CodeBuilderState(selectedBlocks: []);
  bool _isExecuting = false;
  bool _showHint = false;

  CodeChallenge? get _currentChallenge => CodeChallengesData.getChallenge(_currentChallengeId);

  @override
  void initState() {
    super.initState();
    _resetChallenge();
  }

  void _resetChallenge() {
    setState(() {
      _gameState = const CodeBuilderState(selectedBlocks: []);
      _isExecuting = false;
      _showHint = false;
    });
  }

  void _onBlockSelected(CodeBlock block) {
    if (_isExecuting || _gameState.isComplete) return;

    final challenge = _currentChallenge;
    if (challenge == null) return;

    if (_gameState.selectedBlocks.length >= challenge.maxBlocks) {
      _showMessage('لقد وصلت للحد الأقصى من الكتل!', isError: true);
      return;
    }

    setState(() {
      _gameState = _gameState.copyWith(
        selectedBlocks: [..._gameState.selectedBlocks, block],
      );
    });
  }

  void _removeBlock(int index) {
    if (_isExecuting) return;

    setState(() {
      List<CodeBlock> newBlocks = [..._gameState.selectedBlocks];
      newBlocks.removeAt(index);
      _gameState = _gameState.copyWith(selectedBlocks: newBlocks);
    });
  }

  void _clearAll() {
    if (_isExecuting) return;

    setState(() {
      _gameState = _gameState.copyWith(selectedBlocks: []);
    });
  }

  Future<void> _executeCode() async {
    if (_gameState.selectedBlocks.isEmpty || _isExecuting) return;

    final challenge = _currentChallenge;
    if (challenge == null) return;

    setState(() {
      _isExecuting = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    String output = CodeChallengesData.executeCode(_gameState.selectedBlocks);
    bool isCorrect = output == challenge.expectedOutput;
    
    setState(() {
      _gameState = _gameState.copyWith(
        currentOutput: output,
        isComplete: isCorrect,
        hasError: !isCorrect && output.isNotEmpty,
        errorMessage: !isCorrect ? 'النتيجة غير صحيحة' : null,
        score: isCorrect ? _gameState.score + 10 : _gameState.score,
      );
      _isExecuting = false;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    
    if (isCorrect) {
      _showSuccessDialog();
    } else {
      _showMessage('النتيجة غير صحيحة. حاول مرة أخرى!', isError: true);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.celebration, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            const Text('ممتاز!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('لقد حللت التحدي ${_currentChallenge?.id} بنجاح!'),
            const SizedBox(height: 8),
            Text('النقاط: ${_gameState.score}'),
          ],
        ),
        actions: [
          if (_currentChallengeId < CodeChallengesData.totalChallenges)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _nextChallenge();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('التحدي التالي'),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetChallenge();
            },
            child: const Text('إعادة المحاولة'),
          ),
          if (_currentChallengeId >= CodeChallengesData.totalChallenges)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Return to game selection
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('إنهاء اللعبة'),
            ),
        ],
      ),
    );
  }

  void _nextChallenge() {
    if (_currentChallengeId < CodeChallengesData.totalChallenges) {
      setState(() {
        _currentChallengeId++;
      });
      _resetChallenge();
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleHint() {
    setState(() {
      _showHint = !_showHint;
    });
  }

  @override
  Widget build(BuildContext context) {
    final challenge = _currentChallenge;
    if (challenge == null) {
      return const Center(
        child: Text('خطأ في تحميل التحدي'),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
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
                              'التحدي ${challenge.id}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              challenge.title,
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
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'النقاط: ${_gameState.score}',
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
                    challenge.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Text(
                      'المطلوب: ${challenge.problem}',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Text(
                            'النتيجة المتوقعة: ${challenge.expectedOutput}',
                            style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: _toggleHint,
                        icon: Icon(_showHint ? Icons.lightbulb : Icons.lightbulb_outline),
                        label: Text(_showHint ? 'إخفاء التلميح' : 'تلميح'),
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
                  
                  if (_showHint) ...[
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
                              challenge.hint,
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
            ),
            
            Expanded(
              child: Row(
                children: [
                  // Available blocks
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.widgets,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'كتل الكود المتاحة',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: challenge.availableBlocks.length,
                              itemBuilder: (context, index) {
                                final block = challenge.availableBlocks[index];
                                return CodeBlockWidget(
                                  codeBlock: block,
                                  onTap: () => _onBlockSelected(block),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Solution area
                  Expanded(
                    flex: 1,
                    child: SolutionArea(
                      selectedBlocks: _gameState.selectedBlocks,
                      onRemoveBlock: _removeBlock,
                      onExecute: _executeCode,
                      onClear: _clearAll,
                      currentOutput: _gameState.currentOutput,
                      isExecuting: _isExecuting,
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

