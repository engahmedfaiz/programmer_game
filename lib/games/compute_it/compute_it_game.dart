import 'package:flutter/material.dart';
import 'models/compute_challenge.dart';
import 'data/compute_challenges_data.dart';
import 'widgets/code_display.dart';
import 'widgets/variables_panel.dart';
import 'widgets/step_explanation.dart';

class ComputeItGame extends StatefulWidget {
  const ComputeItGame({super.key});

  @override
  State<ComputeItGame> createState() => _ComputeItGameState();
}

class _ComputeItGameState extends State<ComputeItGame> {
  int _currentChallengeId = 2
  ;
  ComputeGameState _gameState = const ComputeGameState(
    currentStep: 0,
    currentVariables: {},
    outputs: [],
    stepResults: [],
  );
  Map<String, String> _userInputs = {};
  String _userOutput = '';

  ComputeChallenge? get _currentChallenge => ComputeChallengesData.getChallenge(_currentChallengeId);

  @override
  void initState() {
    super.initState();
    _resetChallenge();
  }

  void _resetChallenge() {
    final challenge = _currentChallenge;
    if (challenge == null) return;

    setState(() {
      _gameState = ComputeGameState(
        currentStep: 0,
        currentVariables: Map.from(challenge.initialVariables),
        outputs: [],
        stepResults: List.filled(challenge.steps.length, false),
      );
      _userInputs.clear();
      _userOutput = '';
    });
  }

  void _onVariableChanged(String varName, String value) {
    setState(() {
      _userInputs[varName] = value;
      
      // Try to parse the value
      dynamic parsedValue;
      if (value.startsWith('"') && value.endsWith('"')) {
        parsedValue = value.substring(1, value.length - 1);
      } else {
        parsedValue = int.tryParse(value) ?? double.tryParse(value) ?? value;
      }
      
      _gameState = _gameState.copyWith(
        currentVariables: {..._gameState.currentVariables, varName: parsedValue},
      );
    });
  }

  void _onOutputChanged(String output) {
    setState(() {
      _userOutput = output;
    });
  }

  void _checkStep() {
    final challenge = _currentChallenge;
    if (challenge == null || _gameState.currentStep >= challenge.steps.length) return;

    ComputeStep currentStep = challenge.steps[_gameState.currentStep];
    bool isCorrect = ComputeChallengesData.checkStepAnswer(
      currentStep,
      _gameState.currentVariables,
      currentStep.output != null ? _userOutput : null,
    );

    List<bool> newStepResults = [..._gameState.stepResults];
    newStepResults[_gameState.currentStep] = isCorrect;

    if (isCorrect) {
      // Move to next step
      int nextStep = _gameState.currentStep + 1;
      bool isComplete = nextStep >= challenge.steps.length;
      
      setState(() {
        _gameState = _gameState.copyWith(
          currentStep: nextStep,
          currentVariables: Map.from(currentStep.variablesAfter),
          outputs: currentStep.output != null 
              ? [..._gameState.outputs, currentStep.output!]
              : _gameState.outputs,
          isComplete: isComplete,
          score: _gameState.score + 10,
          stepResults: newStepResults,
        );
        _userInputs.clear();
        _userOutput = '';
      });

      if (isComplete) {
        _showSuccessDialog();
      }
    } else {
      setState(() {
        _gameState = _gameState.copyWith(
          hasError: true,
          errorMessage: 'الإجابة غير صحيحة. راجع القيم مرة أخرى.',
          stepResults: newStepResults,
        );
      });
      
      _showMessage('الإجابة غير صحيحة. حاول مرة أخرى!', isError: true);
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
            Text('لقد فهمت كيف ينفذ الكمبيوتر التحدي ${_currentChallenge?.id}!'),
            const SizedBox(height: 8),
            Text('النقاط: ${_gameState.score}'),
          ],
        ),
        actions: [
          if (_currentChallengeId < ComputeChallengesData.totalChallenges)
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
          if (_currentChallengeId >= ComputeChallengesData.totalChallenges)
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
    if (_currentChallengeId < ComputeChallengesData.totalChallenges) {
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

  void _showHint() {
    final challenge = _currentChallenge;
    if (challenge == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber, size: 24),
            const SizedBox(width: 8),
            const Text('تلميح'),
          ],
        ),
        content: Text(challenge.hint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final challenge = _currentChallenge;
    if (challenge == null) {
      return const Center(
        child: Text('خطأ في تحميل التحدي'),
      );
    }

    ComputeStep? currentStep = _gameState.currentStep < challenge.steps.length 
        ? challenge.steps[_gameState.currentStep] 
        : null;

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
                              'Compute It - التحدي ${challenge.id}',
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
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    challenge.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: _gameState.currentStep / challenge.steps.length,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_gameState.currentStep}/${challenge.steps.length}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: _showHint,
                        icon: const Icon(Icons.lightbulb_outline),
                        label: const Text('تلميح'),
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
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Code display
                    CodeDisplay(
                      code: challenge.code,
                      currentStep: _gameState.currentStep,
                      steps: challenge.steps,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Variables panel
                        Expanded(
                          flex: 1,
                          child: VariablesPanel(
                            variables: _gameState.currentVariables,
                            expectedVariables: currentStep?.variablesAfter ?? {},
                            onVariableChanged: _onVariableChanged,
                            isInteractive: !_gameState.isComplete,
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Step explanation
                        Expanded(
                          flex: 1,
                          child: currentStep != null
                              ? StepExplanation(
                                  step: currentStep,
                                  isCompleted: _gameState.currentStep > challenge.steps.indexOf(currentStep),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.green[200]!),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.celebration,
                                        color: Colors.green[600],
                                        size: 48,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'تم إنهاء جميع الخطوات!',
                                        style: TextStyle(
                                          color: Colors.green[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                    
                    // Output section if needed
                    if (currentStep?.output != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ما هو الإخراج المتوقع؟',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'أدخل الإخراج المتوقع...',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: _onOutputChanged,
                              controller: TextEditingController(text: _userOutput),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 16),
                    
                    // Action button
                    if (!_gameState.isComplete)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _checkStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'تحقق من الخطوة ${_gameState.currentStep + 1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

