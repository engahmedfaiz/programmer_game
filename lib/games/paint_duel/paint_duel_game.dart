import 'package:flutter/material.dart';

class PaintDuelGame extends StatefulWidget {
  const PaintDuelGame({super.key});

  @override
  State<PaintDuelGame> createState() => _PaintDuelGameState();
}

class _PaintDuelGameState extends State<PaintDuelGame>
    with TickerProviderStateMixin {
  int _currentRound = 1;
  int _playerScore = 0;
  int _aiScore = 0;
  List<List<String>> _grid = [];
  String _currentPlayerColor = 'blue';
  String _currentAiColor = 'red';
  bool _isPlayerTurn = true;
  bool _gameEnded = false;
  String _currentCode = '';
  Map<String, dynamic> _codeAnalysis = {};
  int _aiMoveIndex = 0;

  late AnimationController _blinkController;

  final List<Map<String, dynamic>> _rounds = [
    // ----------------------------- المستويات العشرة -----------------------------
    {
      'id': 1,
      'title': 'الجولة 1',
      'description': 'اقرأ الكود وتوقع حركة الخصم',
      'gridSize': 5,
      'code': '''for i in range(3):
    if i % 2 == 0:
        paint_cell(i, 0, "red")
    else:
        paint_cell(i, 1, "red")''',
      'aiMoves': [
        [0, 0],
        [1, 1],
        [2, 0],
      ],
    },
    {
      'id': 2,
      'title': 'الجولة 2',
      'description': 'استراتيجية متقدمة',
      'gridSize': 6,
      'code': '''x, y = 0, 0
for step in range(4):
    paint_cell(x, y, "red")
    if step < 2:
        x += 1
    else:
        y += 1''',
      'aiMoves': [
        [0, 0],
        [1, 0],
        [2, 0],
        [2, 1],
      ],
    },
    {
      'id': 3,
      'title': 'الجولة 3',
      'description': 'تحدي الخبراء',
      'gridSize': 7,
      'code': '''pattern = [(0,0), (1,1), (2,2), (1,3), (0,4)]
for pos in pattern:
    x, y = pos
    if x + y < 4:
        paint_cell(x, y, "red")''',
      'aiMoves': [
        [0, 0],
        [1, 1],
        [2, 2],
        [1, 3],
      ],
    },
    {
      'id': 4,
      'title': 'الجولة 4',
      'description': 'زيادة التعقيد',
      'gridSize': 5,
      'code': '''for i in range(5):
    paint_cell(i, i, "red")''',
      'aiMoves': [
        [0, 0],
        [1, 1],
        [2, 2],
        [3, 3],
        [4, 4],
      ],
    },
    {
      'id': 5,
      'title': 'الجولة 5',
      'description': 'نماذج متقاطعة',
      'gridSize': 6,
      'code': '''for i in range(3):
    paint_cell(i, 0, "red")
    paint_cell(i, 5, "red")''',
      'aiMoves': [
        [0, 0],
        [0, 5],
        [1, 0],
        [1, 5],
        [2, 0],
        [2, 5],
      ],
    },
    {
      'id': 6,
      'title': 'الجولة 6',
      'description': 'نمط قطري',
      'gridSize': 7,
      'code': '''for i in range(4):
    paint_cell(i, 6-i, "red")''',
      'aiMoves': [
        [0, 6],
        [1, 5],
        [2, 4],
        [3, 3],
      ],
    },
    {
      'id': 7,
      'title': 'الجولة 7',
      'description': 'مزيج خطوط وقطري',
      'gridSize': 5,
      'code': '''paint_cell(0, 0, "red")
paint_cell(0, 4, "red")
paint_cell(2, 2, "red")''',
      'aiMoves': [
        [0, 0],
        [0, 4],
        [2, 2],
      ],
    },
    {
      'id': 8,
      'title': 'الجولة 8',
      'description': 'نمط مربع',
      'gridSize': 6,
      'code': '''for x in range(2,4):
  for y in range(2,4):
      paint_cell(x, y, "red")''',
      'aiMoves': [
        [2, 2],
        [2, 3],
        [3, 2],
        [3, 3],
      ],
    },
    {
      'id': 9,
      'title': 'الجولة 9',
      'description': 'تحدي ذكي',
      'gridSize': 7,
      'code': '''pattern = [(0,0),(6,6),(3,3),(0,6),(6,0)]
for pos in pattern:
    x, y = pos
    paint_cell(x, y, "red")''',
      'aiMoves': [
        [0, 0],
        [6, 6],
        [3, 3],
        [0, 6],
        [6, 0],
      ],
    },
    {
      'id': 10,
      'title': 'الجولة 10',
      'description': 'الجولة النهائية الكبرى',
      'gridSize': 8,
      'code': '''for i in range(4):
    paint_cell(i, i, "red")
    paint_cell(7-i, i, "red")''',
      'aiMoves': [
        [0, 0],
        [7, 0],
        [1, 1],
        [6, 1],
        [2, 2],
        [5, 2],
        [3, 3],
        [4, 3],
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _startRound();
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  void _startRound() {
    if (_currentRound > _rounds.length) {
      _endGame();
      return;
    }
    Map<String, dynamic> round = _rounds[_currentRound - 1];
    int gridSize = round['gridSize'];
    setState(() {
      _grid = List.generate(gridSize, (i) => List.generate(gridSize, (j) => ''));
      _currentCode = round['code'];
      _isPlayerTurn = true;
      _gameEnded = false;
      _aiMoveIndex = 0;
      _analyzeCode();
    });
  }

  void _analyzeCode() {
    Map<String, dynamic> round = _rounds[_currentRound - 1];
    List<dynamic> aiMoves = round['aiMoves'];
    setState(() {
      _codeAnalysis = {
        'totalMoves': aiMoves.length,
        'pattern': 'خطي',
        'strategy': 'الذكاء الاصطناعي سيلون الخلايا حسب النمط المحدد في الكود',
      };
    });
  }

  void _paintCell(int x, int y) {
    if (!_isPlayerTurn || _grid[y][x].isNotEmpty || _gameEnded) return;
    setState(() {
      _grid[y][x] = _currentPlayerColor;
      _isPlayerTurn = false;
    });
    Future.delayed(const Duration(milliseconds: 500), _aiMove);
  }

  void _aiMove() {
    if (_gameEnded) return;
    Map<String, dynamic> round = _rounds[_currentRound - 1];
    List<dynamic> aiMoves = round['aiMoves'];
    if (_aiMoveIndex < aiMoves.length) {
      List<int> nextMove = List<int>.from(aiMoves[_aiMoveIndex]);
      int aiX = nextMove[0];
      int aiY = nextMove[1];
      if (aiY < _grid.length && aiX < _grid[0].length && _grid[aiY][aiX].isEmpty) {
        setState(() {
          _grid[aiY][aiX] = _currentAiColor;
        });
      }
      _aiMoveIndex++;
    }
    setState(() {
      _isPlayerTurn = true;
    });
    _checkRoundEnd();
  }

  void _checkRoundEnd() {
    bool gridFull = true;
    for (int y = 0; y < _grid.length; y++) {
      for (int x = 0; x < _grid[y].length; x++) {
        if (_grid[y][x].isEmpty) {
          gridFull = false;
          break;
        }
      }
      if (!gridFull) break;
    }
    Map<String, dynamic> round = _rounds[_currentRound - 1];
    List<dynamic> aiMoves = round['aiMoves'];
    if (gridFull || _aiMoveIndex >= aiMoves.length) _endRound();
  }

  void _endRound() {
    int playerCells = 0;
    int aiCells = 0;
    for (int y = 0; y < _grid.length; y++) {
      for (int x = 0; x < _grid[y].length; x++) {
        if (_grid[y][x] == _currentPlayerColor) playerCells++;
        else if (_grid[y][x] == _currentAiColor) aiCells++;
      }
    }
    setState(() {
      _playerScore += playerCells;
      _aiScore += aiCells;
      _gameEnded = true;
    });
    _showRoundResultDialog(playerCells, aiCells);
  }

  void _showRoundResultDialog(int playerCells, int aiCells) {
    String result = playerCells > aiCells
        ? '🎉 فزت!'
        : playerCells < aiCells
        ? '😢 خسرت!'
        : '🤝 تعادل!';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('نتيجة الجولة $_currentRound'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(result, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('خلاياك: $playerCells'),
            Text('خلايا الذكاء الاصطناعي: $aiCells'),
            const SizedBox(height: 8),
            Text('النقاط الإجمالية:'),
            Text('أنت: $_playerScore | الذكاء الاصطناعي: $_aiScore'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (_currentRound < _rounds.length) {
                setState(() => _currentRound++);
                _startRound();
              } else {
                _endGame();
              }
            },
            child: Text(_currentRound < _rounds.length ? 'الجولة التالية' : 'النتيجة النهائية'),
          ),
        ],
      ),
    );
  }

  void _endGame() {
    String finalResult = _playerScore > _aiScore
        ? '🥳 تهانينا! لقد فزت!'
        : _playerScore < _aiScore
        ? '😢 حاول مرة أخرى!'
        : '🤝 تعادل رائع!';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('انتهت اللعبة!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(finalResult, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('النتيجة النهائية:'),
            Text('أنت: $_playerScore'),
            Text('الذكاء الاصطناعي: $_aiScore'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('العودة للقائمة'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentRound = 1;
                _playerScore = 0;
                _aiScore = 0;
              });
              _startRound();
            },
            child: const Text('لعب مرة أخرى'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentRound > _rounds.length) return const Center(child: Text('انتهت اللعبة'));
    Map<String, dynamic> currentRound = _rounds[_currentRound - 1];

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
                            Text('Paint Duel',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(currentRound['title'],
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(child: _scoreBadge('أنت', _playerScore, Colors.blue)),
                      const SizedBox(width: 8),
                      Flexible(child: _scoreBadge('AI', _aiScore, Colors.red)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(currentRound['description'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  FadeTransition(
                    opacity: _blinkController,
                    child: Text(
                      _isPlayerTurn
                          ? '🎨 دورك - اختر خلية للتلوين'
                          : '🤖 دور الذكاء الاصطناعي...',
                      style: TextStyle(
                        color: _isPlayerTurn ? Colors.blue[600] : Colors.red[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 1, child: _buildCodePanel()),
                  Expanded(flex: 1, child: _buildGridPanel()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreBadge(String label, int score, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$label: $score',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildCodePanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('كود الذكاء الاصطناعي:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _currentCode,
                style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            Text('تحليل الكود:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('عدد الحركات المتوقعة: ${_codeAnalysis['totalMoves'] ?? 0}', style: const TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text('النمط: ${_codeAnalysis['pattern'] ?? 'غير محدد'}', style: const TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Text(_codeAnalysis['strategy'] ?? '', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(builder: (context, constraints) {
        final int gridSize = _grid.isNotEmpty ? _grid.length : 5;
        double availableWidth = constraints.maxWidth - 32;
        if (availableWidth < 0) availableWidth = 0;
        double cellSize = (availableWidth / gridSize) - 4;
        cellSize = cellSize.clamp(24.0, 48.0);
        final bool enableHorizontalScroll = ((availableWidth / gridSize) - 4) < 24.0;

        return Center(
          child: SingleChildScrollView(
            scrollDirection: enableHorizontalScroll ? Axis.horizontal : Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: _grid.isEmpty
                  ? const SizedBox(width: 120, height: 120, child: Center(child: CircularProgressIndicator()))
                  : Column(mainAxisSize: MainAxisSize.min, children: _buildGridRows(cellSize)),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _buildGridRows(double cellSize) {
    List<Widget> rows = [];
    for (int y = 0; y < _grid.length; y++) {
      List<Widget> cells = [];
      for (int x = 0; x < _grid[y].length; x++) {
        String cellColor = _grid[y][x];
        cells.add(GestureDetector(
          onTap: () => _paintCell(x, y),
          child: Container(
            width: cellSize,
            height: cellSize,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _getCellColor(cellColor),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[400]!, width: cellColor.isEmpty ? 1 : 2),
            ),
            child: cellColor.isNotEmpty ? const Center(child: Icon(Icons.brush, color: Colors.white, size: 20)) : null,
          ),
        ));
      }
      rows.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: cells));
    }
    return rows;
  }

  Color _getCellColor(String color) {
    switch (color) {
      case 'blue':
        return Colors.blue[400]!;
      case 'red':
        return Colors.red[400]!;
      default:
        return Colors.white;
    }
  }
}
