import 'package:flutter/material.dart';
import '../models/code_challenge.dart';

class CodeBlockWidget extends StatelessWidget {
  final CodeBlock codeBlock;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isInSolution;

  const CodeBlockWidget({
    super.key,
    required this.codeBlock,
    this.isSelected = false,
    this.onTap,
    this.isInSolution = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _getBorderColor(context),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              _getIconForBlockType(codeBlock.type),
              color: _getIconColor(context),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                codeBlock.displayText,
                style: TextStyle(
                  color: _getTextColor(context),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            if (isInSolution)
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isInSolution) {
      return Colors.green[50]!;
    }
    if (isSelected) {
      return Theme.of(context).primaryColor.withOpacity(0.1);
    }
    
    switch (codeBlock.type) {
      case CodeBlockType.variable:
        return Colors.blue[50]!;
      case CodeBlockType.function:
        return Colors.purple[50]!;
      case CodeBlockType.loop:
        return Colors.orange[50]!;
      case CodeBlockType.condition:
        return Colors.red[50]!;
      case CodeBlockType.operation:
        return Colors.teal[50]!;
      case CodeBlockType.output:
        return Colors.green[50]!;
      case CodeBlockType.input:
        return Colors.yellow[50]!;
      default:
        return Colors.grey[50]!;
    }
  }

  Color _getBorderColor(BuildContext context) {
    if (isInSolution) {
      return Colors.green;
    }
    if (isSelected) {
      return Theme.of(context).primaryColor;
    }
    
    switch (codeBlock.type) {
      case CodeBlockType.variable:
        return Colors.blue[300]!;
      case CodeBlockType.function:
        return Colors.purple[300]!;
      case CodeBlockType.loop:
        return Colors.orange[300]!;
      case CodeBlockType.condition:
        return Colors.red[300]!;
      case CodeBlockType.operation:
        return Colors.teal[300]!;
      case CodeBlockType.output:
        return Colors.green[300]!;
      case CodeBlockType.input:
        return Colors.yellow[300]!;
      default:
        return Colors.grey[300]!;
    }
  }

  Color _getIconColor(BuildContext context) {
    if (isInSolution) {
      return Colors.green[600]!;
    }
    
    switch (codeBlock.type) {
      case CodeBlockType.variable:
        return Colors.blue[600]!;
      case CodeBlockType.function:
        return Colors.purple[600]!;
      case CodeBlockType.loop:
        return Colors.orange[600]!;
      case CodeBlockType.condition:
        return Colors.red[600]!;
      case CodeBlockType.operation:
        return Colors.teal[600]!;
      case CodeBlockType.output:
        return Colors.green[600]!;
      case CodeBlockType.input:
        return Colors.yellow[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (isInSolution) {
      return Colors.green[800]!;
    }
    return Colors.grey[800]!;
  }

  IconData _getIconForBlockType(CodeBlockType type) {
    switch (type) {
      case CodeBlockType.variable:
        return Icons.storage;
      case CodeBlockType.function:
        return Icons.functions;
      case CodeBlockType.loop:
        return Icons.loop;
      case CodeBlockType.condition:
        return Icons.alt_route;
      case CodeBlockType.operation:
        return Icons.calculate;
      case CodeBlockType.output:
        return Icons.print;
      case CodeBlockType.input:
        return Icons.input;
      default:
        return Icons.code;
    }
  }
}

