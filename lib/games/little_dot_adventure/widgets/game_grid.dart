import 'package:flutter/material.dart';
import '../models/dot_level.dart';

class GameGrid extends StatelessWidget {
  final DotLevel level;
  final Position currentPosition;
  final List<Position> visitedPositions;

  const GameGrid({
    super.key,
    required this.level,
    required this.currentPosition,
    this.visitedPositions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: level.grid[0].length,
            ),
            itemCount: level.grid.length * level.grid[0].length,
            itemBuilder: (context, index) {
              int row = index ~/ level.grid[0].length;
              int col = index % level.grid[0].length;
              Position cellPosition = Position(col, row);
              
              return _buildGridCell(cellPosition, row, col);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGridCell(Position cellPosition, int row, int col) {
    String cellContent = level.grid[row][col];
    bool isCurrentPosition = cellPosition == currentPosition;
    bool isVisited = visitedPositions.contains(cellPosition);
    bool isStart = cellPosition == level.startPosition;
    bool isTarget = cellPosition == level.targetPosition;

    Color backgroundColor = Colors.white;
    if (isCurrentPosition) {
      backgroundColor = Colors.blue[100]!;
    } else if (isVisited) {
      backgroundColor = Colors.green[50]!;
    } else if (isStart) {
      backgroundColor = Colors.red[50]!;
    } else if (isTarget) {
      backgroundColor = Colors.yellow[50]!;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
      ),
      child: Center(
        child: _buildCellContent(cellContent, isCurrentPosition, cellPosition),
      ),
    );
  }

  Widget _buildCellContent(String cellContent, bool isCurrentPosition, Position cellPosition) {
    if (isCurrentPosition) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.circle,
          color: Colors.white,
          size: 12,
        ),
      );
    }

    switch (cellContent) {
      case '🔴':
        return const Icon(Icons.play_arrow, color: Colors.red, size: 24);
      case '🎯':
        return const Icon(Icons.flag, color: Colors.green, size: 24);
      case '⬛':
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
        );
      case '⭐':
        return const Icon(Icons.star, color: Colors.amber, size: 20);
      case '⬜':
      default:
        return const SizedBox.shrink();
    }
  }
}

