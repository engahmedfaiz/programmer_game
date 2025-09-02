import 'package:flutter/material.dart';
import 'models/dot_level.dart';
import 'data/dot_levels_data.dart';
import 'widgets/game_grid.dart';
import 'widgets/command_panel.dart';
import 'widgets/level_header.dart';

class LittleDotAdventureGame extends StatefulWidget {
  const LittleDotAdventureGame({super.key});

  @override
  State<LittleDotAdventureGame> createState() => _LittleDotAdventureGameState();
}

class _LittleDotAdventureGameState extends State<LittleDotAdventureGame> {
  int _currentLevelId = 1;
  GameState _gameState = const GameState(
    currentPosition: Position(0, 2),
    executedCommands: [],
  );
  List<String> _selectedCommands = [];
  List<Position> _visitedPositions = [];
  bool _isExecuting = false;
  bool _showHint = false;

  DotLevel? get _currentLevel => DotLevelsData.getLevel(_currentLevelId);

  @override
  void initState() {
    super.initState();
    _resetLevel();
  }

  void _resetLevel() {
    final level = _currentLevel;
    if (level != null) {
      setState(() {
        _gameState = GameState(
          currentPosition: level.startPosition,
          executedCommands: [],
        );
        _selectedCommands.clear();
        _visitedPositions = [level.startPosition];
        _isExecuting = false;
        _showHint = false;
      });
    }
  }

  void _onCommandSelected(String command) {
    if (_isExecuting || _gameState.isComplete || _gameState.hasFailed) return;

    setState(() {
      _selectedCommands.add(command);
    });
  }

  void _removeCommand(int index) {
    if (_isExecuting) return;

    setState(() {
      _selectedCommands.removeAt(index);
    });
  }

  Future<void> _executeCommands() async {
    if (_selectedCommands.isEmpty || _isExecuting) return;

    final level = _currentLevel;
    if (level == null) return;

    setState(() {
      _isExecuting = true;
    });

    GameState currentState = GameState(
      currentPosition: level.startPosition,
      executedCommands: [],
    );
    
    List<Position> newVisitedPositions = [level.startPosition];

    for (String command in _selectedCommands) {
      await Future.delayed(const Duration(milliseconds: 800));
      
      currentState = DotLevelsData.executeCommand(level, currentState, command);
      
      setState(() {
        _gameState = currentState;
        if (!newVisitedPositions.contains(currentState.currentPosition)) {
          newVisitedPositions.add(currentState.currentPosition);
        }
        _visitedPositions = newVisitedPositions;
      });

      if (currentState.isComplete || currentState.hasFailed) {
        break;
      }
    }

    setState(() {
      _isExecuting = false;
    });

    // Show result dialog
    await Future.delayed(const Duration(milliseconds: 500));
    _showResultDialog();
  }

  void _showResultDialog() {
    if (_gameState.isComplete) {
      _showSuccessDialog();
    } else if (_gameState.hasFailed) {
      _showFailureDialog();
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
            const Text('أحسنت!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('لقد أكملت المستوى ${_currentLevel?.id} بنجاح!'),
            const SizedBox(height: 8),
            Text('عدد الحركات: ${_gameState.executedCommands.length}/${_currentLevel?.maxMoves}'),
          ],
        ),
        actions: [
          if (_currentLevelId < DotLevelsData.totalLevels)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _nextLevel();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('المستوى التالي'),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetLevel();
            },
            child: const Text('إعادة المحاولة'),
          ),
          if (_currentLevelId >= DotLevelsData.totalLevels)
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

  void _showFailureDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28),
            const SizedBox(width: 8),
            const Text('حاول مرة أخرى'),
          ],
        ),
        content: Text(_gameState.failureReason ?? 'لم تتمكن من إكمال المستوى'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _resetLevel();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('إعادة المحاولة'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _showHint = true;
              });
            },
            child: const Text('إظهار التلميح'),
          ),
        ],
      ),
    );
  }

  void _nextLevel() {
    if (_currentLevelId < DotLevelsData.totalLevels) {
      setState(() {
        _currentLevelId++;
      });
      _resetLevel();
    }
  }

  void _toggleHint() {
    setState(() {
      _showHint = !_showHint;
    });
  }

  @override
  Widget build(BuildContext context) {
    final level = _currentLevel;
    if (level == null) {
      return const Center(
        child: Text('خطأ في تحميل المستوى'),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LevelHeader(
              level: level,
              currentMoves: _gameState.executedCommands.length,
              showHint: _showHint,
              onHintToggle: _toggleHint,
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GameGrid(
                      level: level,
                      currentPosition: _gameState.currentPosition,
                      visitedPositions: _visitedPositions,
                    ),
                    
                    CommandPanel(
                      availableCommands: level.availableCommands,
                      selectedCommands: _selectedCommands,
                      onCommandSelected: _onCommandSelected,
                      onExecute: _executeCommands,
                      onReset: _resetLevel,
                      isExecuting: _isExecuting,
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

