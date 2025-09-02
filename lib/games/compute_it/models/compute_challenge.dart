class ComputeChallenge {
  final int id;
  final String title;
  final String description;
  final String code;
  final List<ComputeStep> steps;
  final Map<String, dynamic> initialVariables;
  final String expectedOutput;
  final String hint;
  final ComputeChallengeType type;

  const ComputeChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.code,
    required this.steps,
    required this.initialVariables,
    required this.expectedOutput,
    required this.hint,
    required this.type,
  });
}

class ComputeStep {
  final int stepNumber;
  final String instruction;
  final String codeSnippet;
  final Map<String, dynamic> variablesBefore;
  final Map<String, dynamic> variablesAfter;
  final String? output;
  final ComputeStepType type;
  final String explanation;

  const ComputeStep({
    required this.stepNumber,
    required this.instruction,
    required this.codeSnippet,
    required this.variablesBefore,
    required this.variablesAfter,
    this.output,
    required this.type,
    required this.explanation,
  });
}

enum ComputeStepType {
  assignment,
  calculation,
  output,
  condition,
  loop,
  function,
}

enum ComputeChallengeType {
  variables,
  arithmetic,
  conditions,
  loops,
  functions,
  mixed,
}

class ComputeGameState {
  final int currentStep;
  final Map<String, dynamic> currentVariables;
  final List<String> outputs;
  final bool isComplete;
  final bool hasError;
  final String? errorMessage;
  final int score;
  final List<bool> stepResults;

  const ComputeGameState({
    required this.currentStep,
    required this.currentVariables,
    required this.outputs,
    this.isComplete = false,
    this.hasError = false,
    this.errorMessage,
    this.score = 0,
    required this.stepResults,
  });

  ComputeGameState copyWith({
    int? currentStep,
    Map<String, dynamic>? currentVariables,
    List<String>? outputs,
    bool? isComplete,
    bool? hasError,
    String? errorMessage,
    int? score,
    List<bool>? stepResults,
  }) {
    return ComputeGameState(
      currentStep: currentStep ?? this.currentStep,
      currentVariables: currentVariables ?? this.currentVariables,
      outputs: outputs ?? this.outputs,
      isComplete: isComplete ?? this.isComplete,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      score: score ?? this.score,
      stepResults: stepResults ?? this.stepResults,
    );
  }
}

class UserAnswer {
  final String variableName;
  final dynamic value;
  final String? output;

  const UserAnswer({
    required this.variableName,
    required this.value,
    this.output,
  });
}

