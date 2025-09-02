class DotLevel {
  final int id;
  final String title;
  final String description;
  final List<List<String>> grid; // Grid representation
  final Position startPosition;
  final Position targetPosition;
  final List<String> availableCommands;
  final List<String> correctSequence;
  final String hint;
  final int maxMoves;

  const DotLevel({
    required this.id,
    required this.title,
    required this.description,
    required this.grid,
    required this.startPosition,
    required this.targetPosition,
    required this.availableCommands,
    required this.correctSequence,
    required this.hint,
    required this.maxMoves,
  });
}

class Position {
  final int x;
  final int y;

  const Position(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Position && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  Position move(String direction) {
    switch (direction.toLowerCase()) {
      case 'up':
      case 'أعلى':
        return Position(x, y - 1);
      case 'down':
      case 'أسفل':
        return Position(x, y + 1);
      case 'left':
      case 'يسار':
        return Position(x - 1, y);
      case 'right':
      case 'يمين':
        return Position(x + 1, y);
      default:
        return this;
    }
  }
}

class GameState {
  final Position currentPosition;
  final List<String> executedCommands;
  final bool isComplete;
  final bool hasFailed;
  final String? failureReason;

  const GameState({
    required this.currentPosition,
    required this.executedCommands,
    this.isComplete = false,
    this.hasFailed = false,
    this.failureReason,
  });

  GameState copyWith({
    Position? currentPosition,
    List<String>? executedCommands,
    bool? isComplete,
    bool? hasFailed,
    String? failureReason,
  }) {
    return GameState(
      currentPosition: currentPosition ?? this.currentPosition,
      executedCommands: executedCommands ?? this.executedCommands,
      isComplete: isComplete ?? this.isComplete,
      hasFailed: hasFailed ?? this.hasFailed,
      failureReason: failureReason ?? this.failureReason,
    );
  }
}

