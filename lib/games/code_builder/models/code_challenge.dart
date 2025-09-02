class CodeChallenge {
  final int id;
  final String title;
  final String description;
  final String problem;
  final List<CodeBlock> availableBlocks;
  final List<String> correctSolution;
  final String expectedOutput;
  final String hint;
  final int maxBlocks;
  final CodeChallengeType type;

  const CodeChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.problem,
    required this.availableBlocks,
    required this.correctSolution,
    required this.expectedOutput,
    required this.hint,
    required this.maxBlocks,
    required this.type,
  });
}

class CodeBlock {
  final String id;
  final String displayText;
  final String codeValue;
  final CodeBlockType type;
  final Map<String, dynamic>? parameters;

  const CodeBlock({
    required this.id,
    required this.displayText,
    required this.codeValue,
    required this.type,
    this.parameters,
  });
}

enum CodeBlockType {
  variable,
  function,
  loop,
  condition,
  operation,
  output,
  input,
}

enum CodeChallengeType {
  sequence,
  variables,
  functions,
  loops,
  conditions,
  mixed,
}

class CodeBuilderState {
  final List<CodeBlock> selectedBlocks;
  final String currentOutput;
  final bool isComplete;
  final bool hasError;
  final String? errorMessage;
  final int score;

  const CodeBuilderState({
    required this.selectedBlocks,
    this.currentOutput = '',
    this.isComplete = false,
    this.hasError = false,
    this.errorMessage,
    this.score = 0,
  });

  CodeBuilderState copyWith({
    List<CodeBlock>? selectedBlocks,
    String? currentOutput,
    bool? isComplete,
    bool? hasError,
    String? errorMessage,
    int? score,
  }) {
    return CodeBuilderState(
      selectedBlocks: selectedBlocks ?? this.selectedBlocks,
      currentOutput: currentOutput ?? this.currentOutput,
      isComplete: isComplete ?? this.isComplete,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      score: score ?? this.score,
    );
  }
}

