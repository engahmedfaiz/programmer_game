import '../models/dot_level.dart';

class DotLevelsData {
  static const List<DotLevel> _levels = [
    // Level 1: Basic Movement
    DotLevel(
      id: 1,
      title: 'Basic Movement',
      description: 'Learn how to move the small dot. Use commands to reach the target.',
      grid: [
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['🔴', '⬜', '⬜', '⬜', '🎯'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
      ],
      startPosition: Position(0, 2),
      targetPosition: Position(4, 2),
      availableCommands: ['right', 'left', 'up', 'down'],
      correctSequence: ['right', 'right', 'right', 'right'],
      hint: 'حرك النقطة 4 خطوات إلى اليمين للوصول للهدف',
      maxMoves: 6,
    ),

    // Level 2: L-Shaped Path
    DotLevel(
      id: 2,
      title: 'L-Shaped Path',
      description: 'Learn to navigate an L-shaped path. You need to change direction.',
      grid: [
        ['🔴', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '🎯'],
      ],
      startPosition: Position(0, 0),
      targetPosition: Position(4, 4),
      availableCommands: ['right', 'left', 'up', 'down'],
      correctSequence: ['right', 'right', 'right', 'right', 'down', 'down', 'down', 'down'],
      hint: 'اذهب يميناً أولاً، ثم اذهب أسفل للوصول للهدف',
      maxMoves: 10,
    ),

    // Level 3: Obstacles
    DotLevel(
      id: 3,
      title: 'Avoid Obstacles',
      description: 'Learn how to avoid obstacles. Black squares cannot be passed.',
      grid: [
        ['🔴', '⬜', '⬛', '⬜', '🎯'],
        ['⬜', '⬜', '⬛', '⬜', '⬜'],
        ['⬜', '⬜', '⬛', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
      ],
      startPosition: Position(0, 0),
      targetPosition: Position(4, 0),
      availableCommands: ['right', 'left', 'up', 'down'],
      correctSequence: ['down', 'down', 'down', 'right', 'right', 'right', 'right', 'up', 'up', 'up'],
      hint: 'اذهب أسفل لتجنب العائق، ثم يميناً، ثم أعلى للوصول للهدف',
      maxMoves: 12,
    ),

    // Level 4: Collect Items
    DotLevel(
      id: 4,
      title: 'Collect Items',
      description: 'Collect all stars before reaching the target. Pass through all stars.',
      grid: [
        ['🔴', '⭐', '⬜', '⭐', '🎯'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⭐', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
      ],
      startPosition: Position(0, 0),
      targetPosition: Position(4, 0),
      availableCommands: ['right', 'left', 'up', 'down'],
      correctSequence: ['right', 'right', 'down', 'down', 'left', 'left', 'up', 'up', 'right', 'right', 'right'],
      hint: 'اجمع جميع النجوم قبل الوصول إلى الهدف',
      maxMoves: 15,
    ),

    // Level 5: Loop Concept
    DotLevel(
      id: 5,
      title: 'Loop Concept',
      description: 'Learn loops. Repeat the same movement multiple times.',
      grid: [
        ['🔴', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '🎯'],
      ],
      startPosition: Position(0, 0),
      targetPosition: Position(4, 4),
      availableCommands: ['right', 'down', 'repeat(right,4)', 'repeat(down,4)'],
      correctSequence: ['repeat(right,4)', 'repeat(down,4)'],
      hint: 'استخدم أمر التكرار لتحريك النقطة 4 خطوات يميناً، ثم 4 خطوات أسفل',
      maxMoves: 8,
    ),

    // Level 6: Conditional Movement
    DotLevel(
      id: 6,
      title: 'Conditional Movement',
      description: 'Learn conditional moves. Move based on surrounding conditions.',
      grid: [
        ['🔴', '⬜', '⬛', '⬜', '⬜'],
        ['⬜', '⬜', '⬛', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '🎯'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
      ],
      startPosition: Position(0, 0),
      targetPosition: Position(4, 2),
      availableCommands: ['right', 'down', 'if_obstacle_then_down', 'if_empty_then_right'],
      correctSequence: ['right', 'if_obstacle_then_down', 'down', 'right', 'right', 'right'],
      hint: 'تحرك يميناً، وإذا واجهت عائقاً فاذهب أسفل',
      maxMoves: 8,
    ),


    // Level 7: Function Concept
    DotLevel(
      id: 7,
      title: 'Function Concept',
      description: 'Learn how to create and use functions. A function is a set of commands.',
      grid: [
        ['🔴', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '🎯'],
      ],
      startPosition: Position(0, 0),
      targetPosition: Position(4, 4),
      availableCommands: ['define_function(move_diagonal)', 'call_function(move_diagonal)'],
      correctSequence: ['define_function(move_diagonal)', 'call_function(move_diagonal)'],
      hint: 'عرّف دالة للحركة القطرية ثم استدعها عدة مرات للوصول للهدف',
      maxMoves: 8,
    ),

    // Level 8: Complex Maze
    DotLevel(
      id: 8,
      title: 'Complex Maze',
      description: 'Apply all learned concepts in a complex maze.',
      grid: [
        ['🔴', '⬛', '⬜', '⬛', '⬜'],
        ['⬜', '⬛', '⬜', '⬛', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬛', '⬛', '⬜', '⬛', '⬛'],
        ['⬜', '⬜', '⬜', '⬜', '🎯'],
      ],
      startPosition: Position(0, 0),
      targetPosition: Position(4, 4),
      availableCommands: ['right', 'left', 'up', 'down', 'repeat', 'if_obstacle'],
      correctSequence: ['down', 'down', 'right', 'right', 'right', 'right', 'down', 'down'],
      hint: 'ابحث عن المسار الآمن عبر المتاهة',
      maxMoves: 12,
    ),
  ];

  static List<DotLevel> get allLevels => _levels;
  static int get totalLevels => _levels.length;

  static DotLevel? getLevel(int id) {
    try {
      return _levels.firstWhere((level) => level.id == id);
    } catch (e) {
      return null;
    }
  }

  static bool isValidMove(DotLevel level, Position from, String command) {
    Position newPosition = from.move(command);
    if (newPosition.x < 0 || newPosition.x >= level.grid[0].length ||
        newPosition.y < 0 || newPosition.y >= level.grid.length) {
      return false;
    }
    String cell = level.grid[newPosition.y][newPosition.x];
    return cell != '⬛';
  }

  static GameState executeCommand(DotLevel level, GameState currentState, String command) {
    if (currentState.isComplete || currentState.hasFailed) return currentState;

    // Handle repeat
    if (command.startsWith('repeat(')) return _handleRepeatCommand(level, currentState, command);

    // Handle conditional
    if (command.startsWith('if_')) return _handleConditionalCommand(level, currentState, command);

    // Handle function call
    if (command.startsWith('call_function(')) {
      String functionName = command.substring(14, command.length - 1);
      if (functionName == 'move_diagonal') {
        List<String> functionMoves = ['right', 'down'];
        GameState state = currentState;
        while (!state.isComplete && !state.hasFailed) {
          for (String move in functionMoves) {
            state = executeCommand(level, state, move);
            if (state.hasFailed || state.isComplete) break;
          }
          break; // single call executes one diagonal set
        }
        return state;
      }
    }

    if (!isValidMove(level, currentState.currentPosition, command)) {
      return currentState.copyWith(
        hasFailed: true,
        failureReason: 'Invalid move: $command',
      );
    }

    Position newPosition = currentState.currentPosition.move(command);
    List<String> newCommands = [...currentState.executedCommands, command];

    bool isComplete = newPosition == level.targetPosition;
    bool hasFailed = newCommands.length > level.maxMoves && !isComplete;

    return GameState(
      currentPosition: newPosition,
      executedCommands: newCommands,
      isComplete: isComplete,
      hasFailed: hasFailed,
      failureReason: hasFailed ? 'Exceeded maximum moves' : null,
    );
  }

  static GameState _handleRepeatCommand(DotLevel level, GameState currentState, String command) {
    RegExp regExp = RegExp(r'repeat\((.+),(\d+)\)');
    Match? match = regExp.firstMatch(command);

    if (match == null) {
      return currentState.copyWith(
        hasFailed: true,
        failureReason: 'Invalid repeat command: $command',
      );
    }

    String moveCommand = match.group(1)!;
    int repeatCount = int.parse(match.group(2)!);

    GameState state = currentState;
    for (int i = 0; i < repeatCount; i++) {
      state = executeCommand(level, state, moveCommand);
      if (state.hasFailed || state.isComplete) break;
    }
    return state;
  }

  static GameState _handleConditionalCommand(DotLevel level, GameState currentState, String command) {
    if (command == 'if_obstacle_then_down') {
      if (!isValidMove(level, currentState.currentPosition, 'right')) {
        return executeCommand(level, currentState, 'down');
      }
    }
    return currentState;
  }
}