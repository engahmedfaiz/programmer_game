import 'dart:math';
import 'package:flutter/material.dart';

class CodeNSlashGame extends StatefulWidget {
  const CodeNSlashGame({super.key});

  @override
  State<CodeNSlashGame> createState() => _CodeNSlashGameState();
}

class _CodeNSlashGameState extends State<CodeNSlashGame> {
  int _currentLevel = 1;
  int _score = 0;
  List<List<String>> _grid = [];
  int _playerX = 0;
  int _playerY = 0;
  int _enemiesDefeated = 0;
  bool _isGameComplete = false;

  final Random _random = Random();

  final int _totalLevels = 10;
  final Map<int, int> _highScores = {}; // أعلى نقاط لكل مستوى

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  void _loadLevel() {
    if (_currentLevel > _totalLevels) {
      setState(() {
        _isGameComplete = true;
      });
      return;
    }

    // حجم الشبكة يزداد تدريجياً حسب المستوى
    int rows = 3 + _currentLevel ~/ 2;
    int cols = 3 + _currentLevel ~/ 2;

    // إنشاء شبكة فارغة
    _grid = List.generate(rows, (_) => List.generate(cols, (_) => '.'));

    // إنشاء مسار مضمون من P إلى G
    List<Point<int>> path = [];
    _playerX = 0;
    _playerY = 0;
    path.add(Point(_playerX, _playerY));

    while (_playerX != cols - 1 || _playerY != rows - 1) {
      if (_playerX < cols - 1 && (_playerY == rows - 1 || _random.nextBool())) _playerX++;
      else if (_playerY < rows - 1) _playerY++;
      path.add(Point(_playerX, _playerY));
    }

    // وضع اللاعب و الهدف
    _playerX = 0;
    _playerY = 0;
    _grid[rows - 1][cols - 1] = 'G';

    // وضع الأعداء في خلايا غير المسار
    int enemiesCount = min(_currentLevel + 1, rows * cols ~/ 4);
    for (int i = 0; i < enemiesCount; i++) {
      int ex, ey;
      do {
        ex = _random.nextInt(cols);
        ey = _random.nextInt(rows);
      } while (_grid[ey][ex] != '.' || path.contains(Point(ex, ey)));
      _grid[ey][ex] = 'E';
    }

    // وضع الجدران في خلايا غير المسار
    int wallsCount = (rows * cols * 0.2).toInt();
    for (int i = 0; i < wallsCount; i++) {
      int wx, wy;
      do {
        wx = _random.nextInt(cols);
        wy = _random.nextInt(rows);
      } while (_grid[wy][wx] != '.' || path.contains(Point(wx, wy)));
      _grid[wy][wx] = '#';
    }

    _enemiesDefeated = 0;
    setState(() {});
  }

  void _restartLevel() {
    _loadLevel();
    setState(() {});
  }

  void _movePlayer(int dx, int dy) {
    int newX = _playerX + dx;
    int newY = _playerY + dy;

    if (newX < 0 || newX >= _grid[0].length || newY < 0 || newY >= _grid.length) return;

    String cell = _grid[newY][newX];

    if (cell == '#') return; // Wall

    setState(() {
      _playerX = newX;
      _playerY = newY;

      if (cell == 'E') {
        _grid[newY][newX] = '.';
        _enemiesDefeated++;
        _score += 10;
      } else if (cell == 'G') {
        _score += 50;
        _highScores[_currentLevel] = max(_highScores[_currentLevel] ?? 0, _score);
        _currentLevel++;
        _loadLevel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isGameComplete) return _buildGameCompleteScreen();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildGridContainer(),
                      const SizedBox(height: 16),
                      _buildControls(),
                      const SizedBox(height: 16),
                      _buildLegend(),
                      const SizedBox(height: 16),
                      _buildRestartButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
                child: Text(
                  'Code N Slash - المستوى $_currentLevel',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
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
            'الأعداء المهزومون: $_enemiesDefeated',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'أعلى نقاط هذا المستوى: ${_highScores[_currentLevel] ?? 0}',
            style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: _buildGrid(),
      ),
    );
  }

  List<Widget> _buildGrid() {
    List<Widget> rows = [];
    for (int y = 0; y < _grid.length; y++) {
      List<Widget> cells = [];
      for (int x = 0; x < _grid[y].length; x++) {
        String cellContent = _grid[y][x];
        bool isPlayer = (x == _playerX && y == _playerY);

        cells.add(
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _getCellColor(cellContent, isPlayer),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Center(
              child: Text(
                _getCellIcon(cellContent, isPlayer),
                style: const TextStyle(fontSize: 24),
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

  Color _getCellColor(String cell, bool isPlayer) {
    if (isPlayer) return Colors.blue[100]!;
    switch (cell) {
      case '#':
        return Colors.grey[600]!;
      case 'E':
        return Colors.red[100]!;
      case 'G':
        return Colors.green[100]!;
      default:
        return Colors.white;
    }
  }

  String _getCellIcon(String cell, bool isPlayer) {
    if (isPlayer) return '🤖';
    switch (cell) {
      case '#':
        return '🧱';
      case 'E':
        return '👾';
      case 'G':
        return '🏆';
      default:
        return '';
    }
  }

  Widget _buildControls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildControlButton(Icons.keyboard_arrow_up, () => _movePlayer(0, -1))],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildControlButton(Icons.keyboard_arrow_left, () => _movePlayer(-1, 0)),
            const SizedBox(width: 16),
            _buildControlButton(Icons.keyboard_arrow_right, () => _movePlayer(1, 0)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildControlButton(Icons.keyboard_arrow_down, () => _movePlayer(0, 1))],
        ),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Icon(icon, size: 24),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem('🤖', 'اللاعب'),
          _buildLegendItem('👾', 'عدو'),
          _buildLegendItem('🏆', 'الهدف'),
          _buildLegendItem('🧱', 'جدار'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String icon, String label) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildRestartButton() {
    return ElevatedButton.icon(
      onPressed: _restartLevel,
      icon: const Icon(Icons.refresh),
      label: const Text('إعادة تشغيل المستوى'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
    );
  }

  Widget _buildGameCompleteScreen() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.celebration, size: 80, color: Colors.green[600]),
              const SizedBox(height: 16),
              Text(
                'تهانينا!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'لقد أكملت جميع مستويات Code N Slash!',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'النقاط النهائية: $_score',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[600],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('العودة للقائمة الرئيسية'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
