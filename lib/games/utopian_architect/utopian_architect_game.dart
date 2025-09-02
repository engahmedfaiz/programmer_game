import 'package:flutter/material.dart';

class UtopianArchitectGame extends StatefulWidget {
  const UtopianArchitectGame({super.key});

  @override
  State<UtopianArchitectGame> createState() => _UtopianArchitectGameState();
}

class _UtopianArchitectGameState extends State<UtopianArchitectGame> {
  int _currentLevel = 1;
  int _score = 0;
  List<String> _commands = [];
  List<List<String>> _grid = [];
  int _robotX = 0;
  int _robotY = 0;
  bool _isExecuting = false;
  bool _isLevelComplete = false;
  String? _hintCommand;

  final List<Map<String, dynamic>> _levels = [
    {
      'id': 1,
      'title': 'البرج البسيط',
      'description': 'ابنِ برجًا بسيطًا',
      'grid': [
        ['.', '.', '.'],
        ['.', '.', '.'],
        ['R', '.', '.'],
      ],
      'target': [
        ['.', '.', '.'],
        ['.', 'B', '.'],
        ['R', 'B', '.'],
      ],
      'blocks': 2,
    },
    {
      'id': 2,
      'title': 'الجسر',
      'description': 'ابنِ جسراً للعبور',
      'grid': [
        ['R', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', 'G'],
      ],
      'target': [
        ['R', 'B', 'B', 'B', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', 'G'],
      ],
      'blocks': 3,
    },
    {
      'id': 3,
      'title': 'القلعة',
      'description': 'ابنِ قلعة محصنة',
      'grid': [
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['R', '.', '.', '.', '.'],
      ],
      'target': [
        ['.', 'B', 'B', 'B', '.'],
        ['.', 'B', '.', 'B', '.'],
        ['.', 'B', '.', 'B', '.'],
        ['.', 'B', 'B', 'B', '.'],
        ['R', '.', '.', '.', '.'],
      ],
      'blocks': 10,
    },
    {
      'id': 4,
      'title': 'المنصة المعلقة',
      'description': 'انشئ منصة للوصول للأعلى',
      'grid': [
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', 'R', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', 'G'],
      ],
      'target': [
        ['.', '.', '.', '.', '.'],
        ['.', '.', 'B', 'B', 'B'],
        ['.', '.', 'R', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', 'G'],
      ],
      'blocks': 3,
    },
    {
      'id': 5,
      'title': 'الجسر الطويل',
      'description': 'ابنِ جسراً أطول لعبور الخندق',
      'grid': [
        ['R', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', 'G'],
      ],
      'target': [
        ['R', 'B', 'B', 'B', 'B', 'B', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', 'G'],
      ],
      'blocks': 5,
    },
    {
      'id': 6,
      'title': 'القلعة المحصنة',
      'description': 'ابنِ قلعة محصنة أكثر',
      'grid': [
        ['.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.'],
        ['R', '.', '.', '.', '.', '.'],
      ],
      'target': [
        ['.', 'B', 'B', 'B', '.', '.'],
        ['.', 'B', '.', 'B', '.', '.'],
        ['.', 'B', '.', 'B', '.', '.'],
        ['.', 'B', 'B', 'B', '.', '.'],
        ['R', '.', '.', '.', '.', '.'],
      ],
      'blocks': 8,
    },
    {
      'id': 7,
      'title': 'الجسر والمعبر',
      'description': 'اصنع جسراً ومعبراً للوصول للهدف',
      'grid': [
        ['R', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', 'G'],
      ],
      'target': [
        ['R', 'B', 'B', '.', '.'],
        ['.', '.', 'B', '.', '.'],
        ['.', '.', '.', '.', 'G'],
      ],
      'blocks': 4,
    },
    {
      'id': 8,
      'title': 'البرج المرتفع',
      'description': 'ابنِ برجاً أعلى للوصول للهدف',
      'grid': [
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
        ['R', '.', '.', '.'],
        ['.', '.', '.', 'G'],
      ],
      'target': [
        ['.', 'B', '.', '.'],
        ['.', 'B', '.', '.'],
        ['R', 'B', '.', '.'],
        ['.', '.', '.', 'G'],
      ],
      'blocks': 3,
    },
    {
      'id': 9,
      'title': 'الجسر الحلزوني',
      'description': 'اصنع جسراً ملتفاً للوصول للهدف',
      'grid': [
        ['R', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', 'G'],
      ],
      'target': [
        ['R', 'B', '.', '.', '.'],
        ['.', 'B', 'B', '.', '.'],
        ['.', '.', '.', '.', 'G'],
      ],
      'blocks': 4,
    },
    {
      'id': 10,
      'title': 'القلعة الكبرى',
      'description': 'ابنِ أكبر قلعة لإتمام المستوى النهائي',
      'grid': [
        ['.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.'],
        ['R', '.', '.', '.', '.', '.'],
      ],
      'target': [
        ['.', 'B', 'B', 'B', '.', '.'],
        ['.', 'B', '.', 'B', '.', '.'],
        ['.', 'B', '.', 'B', '.', '.'],
        ['.', 'B', 'B', 'B', '.', '.'],
        ['R', '.', '.', '.', '.', '.'],
      ],
      'blocks': 10,
    },
  ];

  final List<String> _availableCommands = [
    'تحرك يميناً',
    'تحرك يساراً',
    'تحرك أعلى',
    'تحرك أسفل',
    'ضع كتلة',
    'كرر 3 مرات',
    'كرر 5 مرات',
  ];

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  void _loadLevel() {
    if (_currentLevel > _levels.length) {
      _showGameCompleteDialog();
      return;
    }

    Map<String, dynamic> level = _levels[_currentLevel - 1];
    List<List<String>> originalGrid = List<List<String>>.from(
      level['grid'].map((row) => List<String>.from(row)),
    );

    setState(() {
      _grid = originalGrid;
      _commands.clear();
      _isLevelComplete = false;
      _hintCommand = null;

      // Find robot position
      for (int y = 0; y < _grid.length; y++) {
        for (int x = 0; x < _grid[y].length; x++) {
          if (_grid[y][x] == 'R') {
            _robotX = x;
            _robotY = y;
            break;
          }
        }
      }
    });
  }

  void _addCommand(String command) {
    if (_commands.length < 10) {
      setState(() {
        _commands.add(command);
      });
    }
  }

  void _removeCommand(int index) {
    setState(() {
      _commands.removeAt(index);
    });
  }

  void _clearCommands() {
    setState(() {
      _commands.clear();
    });
  }

  Future<void> _executeCommands() async {
    setState(() {
      _isExecuting = true;
    });

    // Reset robot position
    Map<String, dynamic> level = _levels[_currentLevel - 1];
    List<List<String>> originalGrid = List<List<String>>.from(
      level['grid'].map((row) => List<String>.from(row)),
    );

    setState(() {
      _grid = originalGrid;
      _hintCommand = null;
      for (int y = 0; y < _grid.length; y++) {
        for (int x = 0; x < _grid[y].length; x++) {
          if (_grid[y][x] == 'R') {
            _robotX = x;
            _robotY = y;
            break;
          }
        }
      }
    });

    await Future.delayed(const Duration(milliseconds: 500));

    for (String command in _commands) {
      await _executeCommand(command);
      await Future.delayed(const Duration(milliseconds: 800));
    }

    _checkLevelComplete();

    setState(() {
      _isExecuting = false;
    });
  }

  Future<void> _executeCommand(String command) async {
    switch (command) {
      case 'تحرك يميناً':
        await _moveRobot(1, 0);
        break;
      case 'تحرك يساراً':
        await _moveRobot(-1, 0);
        break;
      case 'تحرك أعلى':
        await _moveRobot(0, -1);
        break;
      case 'تحرك أسفل':
        await _moveRobot(0, 1);
        break;
      case 'ضع كتلة':
        await _placeBlock();
        break;
      case 'كرر 3 مرات':
        for (int i = 0; i < 3; i++) {
          await _placeBlock();
          await Future.delayed(const Duration(milliseconds: 300));
        }
        break;
      case 'كرر 5 مرات':
        for (int i = 0; i < 5; i++) {
          await _placeBlock();
          await Future.delayed(const Duration(milliseconds: 300));
        }
        break;
    }
  }

  Future<void> _moveRobot(int dx, int dy) async {
    int newX = _robotX + dx;
    int newY = _robotY + dy;

    if (newX >= 0 && newX < _grid[0].length &&
        newY >= 0 && newY < _grid.length &&
        _grid[newY][newX] != 'B') {
      setState(() {
        _grid[_robotY][_robotX] = '.';
        _robotX = newX;
        _robotY = newY;
        _grid[_robotY][_robotX] = 'R';
      });
    }
  }

  Future<void> _placeBlock() async {
    if (_robotX < _grid[0].length - 1 && _grid[_robotY][_robotX + 1] == '.') {
      setState(() {
        _grid[_robotY][_robotX] = 'B';
        _robotX++;
        _grid[_robotY][_robotX] = 'R';
      });
    } else if (_robotY > 0 && _grid[_robotY - 1][_robotX] == '.') {
      setState(() {
        _grid[_robotY][_robotX] = 'B';
        _robotY--;
        _grid[_robotY][_robotX] = 'R';
      });
    }
  }

  void _checkLevelComplete() {
    Map<String, dynamic> level = _levels[_currentLevel - 1];
    List<List<String>> target = List<List<String>>.from(
      level['target'].map((row) => List<String>.from(row)),
    );

    bool isComplete = true;
    for (int y = 0; y < _grid.length; y++) {
      for (int x = 0; x < _grid[y].length; x++) {
        if (target[y][x] == 'B' && _grid[y][x] != 'B') {
          isComplete = false;
          break;
        }
      }
      if (!isComplete) break;
    }

    if (isComplete) {
      setState(() {
        _isLevelComplete = true;
        _score += 100;
      });
      _showLevelCompleteDialog();
    }
  }

  void _generateHint() {
    Map<String, dynamic> level = _levels[_currentLevel - 1];
    List<List<String>> target = List<List<String>>.from(
      level['target'].map((row) => List<String>.from(row)),
    );

    for (int y = 0; y < _grid.length; y++) {
      for (int x = 0; x < _grid[y].length; x++) {
        if (target[y][x] == 'B' && _grid[y][x] != 'B') {
          if (x > _robotX) _hintCommand = 'تحرك يميناً';
          else if (x < _robotX) _hintCommand = 'تحرك يساراً';
          else if (y < _robotY) _hintCommand = 'تحرك أعلى';
          else if (y > _robotY) _hintCommand = 'تحرك أسفل';
          else _hintCommand = 'ضع كتلة';
          setState(() {});
          return;
        }
      }
    }
  }

  void _showLevelCompleteDialog() {
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
        content: Text('لقد أكملت المستوى ${_currentLevel} بنجاح!'),
        actions: [
          if (_currentLevel < _levels.length)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentLevel++;
                });
                _loadLevel();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('المستوى التالي'),
            ),
          if (_currentLevel >= _levels.length)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showGameCompleteDialog();
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

  void _showGameCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.architecture, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            const Text('مهندس معماري!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('تهانينا! لقد أصبحت مهندساً معمارياً ماهراً!'),
            const SizedBox(height: 8),
            Text('النقاط النهائية: $_score'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('العودة للقائمة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentLevelData = _levels[_currentLevel - 1];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                              'Utopian Architect',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              currentLevelData['title'],
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
                          'النقاط: $_score',
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
                    currentLevelData['description'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
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
                          Expanded(
                            child: ListView.builder(
                              itemCount: _availableCommands.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ElevatedButton(
                                    onPressed: _isExecuting ? null : () => _addCommand(_availableCommands[index]),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[100],
                                      foregroundColor: Colors.blue[800],
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    child: Text(_availableCommands[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              children: _buildGrid(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 120,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green[200]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تسلسل الأوامر:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: _commands.isEmpty
                                      ? Center(
                                    child: Text(
                                      'اختر الأوامر من القائمة',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  )
                                      : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _commands.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green[200],
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${index + 1}. ${_commands[index]}',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(width: 4),
                                            GestureDetector(
                                              onTap: () => _removeCommand(index),
                                              child: Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.red[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (_hintCommand != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      'تلميح: $_hintCommand',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[800],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _isExecuting || _commands.isEmpty ? null : _executeCommands,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: Text(_isExecuting ? 'جاري التنفيذ...' : 'تنفيذ الأوامر'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: _isExecuting ? null : _clearCommands,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[400],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                ),
                                child: const Text('مسح'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: _isExecuting ? null : _generateHint,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                ),
                                child: const Text('تلميح'),
                              ),
                            ],
                          ),
                        ],
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

  List<Widget> _buildGrid() {
    List<Widget> rows = [];
    for (int y = 0; y < _grid.length; y++) {
      List<Widget> cells = [];
      for (int x = 0; x < _grid[y].length; x++) {
        String cellContent = _grid[y][x];
        cells.add(
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: _getCellColor(cellContent),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Center(
              child: Text(
                _getCellIcon(cellContent),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cells,
      ));
    }
    return rows;
  }

  Color _getCellColor(String cell) {
    switch (cell) {
      case 'R': return Colors.blue[200]!;
      case 'B': return Colors.brown[300]!;
      case 'G': return Colors.green[200]!;
      default: return Colors.white;
    }
  }

  String _getCellIcon(String cell) {
    switch (cell) {
      case 'R': return '🤖';
      case 'B': return '🧱';
      case 'G': return '🏆';
      default: return '';
    }
  }
}
