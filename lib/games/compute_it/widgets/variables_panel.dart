import 'package:flutter/material.dart';

class VariablesPanel extends StatefulWidget {
  final Map<String, dynamic> variables;
  final Map<String, dynamic> expectedVariables;
  final Function(String, String) onVariableChanged;
  final bool isInteractive;

  const VariablesPanel({
    super.key,
    required this.variables,
    required this.expectedVariables,
    required this.onVariableChanged,
    this.isInteractive = true,
  });

  @override
  State<VariablesPanel> createState() => _VariablesPanelState();
}

class _VariablesPanelState extends State<VariablesPanel> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void didUpdateWidget(covariant VariablesPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initializeControllers();
  }

  void _initializeControllers() {
    final allVariableNames = {...widget.variables.keys, ...widget.expectedVariables.keys};

    for (var varName in allVariableNames) {
      if (!_controllers.containsKey(varName)) {
        _controllers[varName] = TextEditingController(
          text: widget.variables[varName]?.toString() ?? '',
        );
      } else {
        // تحديث القيمة فقط إذا تغيرت من الخارج
        if (_controllers[varName]!.text != widget.variables[varName]?.toString()) {
          _controllers[varName]!.text = widget.variables[varName]?.toString() ?? '';
        }
      }
    }
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.storage, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'المتغيرات في الذاكرة:',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (widget.variables.isEmpty && widget.expectedVariables.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                'لا توجد متغيرات بعد...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _buildVariablesList(),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildVariablesList() {
    final allVariableNames = {...widget.variables.keys, ...widget.expectedVariables.keys};
    List<Widget> widgets = [];

    for (String varName in allVariableNames) {
      final currentValue = widget.variables[varName];
      final expectedValue = widget.expectedVariables[varName];
      final hasExpectedValue = widget.expectedVariables.containsKey(varName);
      final isCorrect = currentValue == expectedValue;
      final hasUserValue = widget.variables.containsKey(varName);

      widgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: hasExpectedValue
                ? (isCorrect ? Colors.green[50] : Colors.red[50])
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasExpectedValue
                  ? (isCorrect ? Colors.green[300]! : Colors.red[300]!)
                  : Colors.grey[300]!,
              width: hasExpectedValue ? 2 : 1,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    varName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '=',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 2),
                SizedBox(
                  width: 55,
                  child: widget.isInteractive && hasExpectedValue
                      ? TextField(
                    controller: _controllers[varName],
                    decoration: InputDecoration(
                      hintText: 'أدخل القيمة...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.onVariableChanged(varName, value);
                    },
                  )
                      : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      currentValue?.toString() ?? '?',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color: hasUserValue ? Colors.black : Colors.grey[500],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (hasExpectedValue)
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.error,
                    color: isCorrect ? Colors.green[600] : Colors.red[600],
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}
