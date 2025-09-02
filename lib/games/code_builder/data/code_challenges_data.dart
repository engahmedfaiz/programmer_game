import '../models/code_challenge.dart';

class CodeChallengesData {
  static const List<CodeChallenge> _challenges = [
    // Challenge 1: Basic Output
    CodeChallenge(
      id: 1,
      title: 'أول برنامج',
      description: 'تعلم كيفية إنشاء أول برنامج لك. اطبع رسالة ترحيب.',
      problem: 'اكتب برنامجاً يطبع "مرحباً بالعالم!"',
      availableBlocks: [
        CodeBlock(
          id: 'print_hello',
          displayText: 'Print "Hello World!"',
          codeValue: 'print("Hello World!")',
          type: CodeBlockType.output,
        ),
        CodeBlock(
          id: 'print_name',
          displayText: 'Print "My name is Ahmed"',
          codeValue: 'print("My name is Ahmed")',
          type: CodeBlockType.output,
        ),
        CodeBlock(
          id: 'print_number',
          displayText: 'Print the number 42',
          codeValue: 'print(42)',
          type: CodeBlockType.output,
        ),
      ],
      correctSolution: ['print("Hello World!")'],
      expectedOutput: 'Hello World!',
      hint: 'استخدم كتلة الطباعة التي تحتوي على "مرحباً بالعالم!"',
      maxBlocks: 3,
      type: CodeChallengeType.sequence,
    ),

    // Challenge 2: Variables
    CodeChallenge(
      id: 2,
      title: 'المتغيرات',
      description: 'تعلم كيفية استخدام المتغيرات لحفظ البيانات.',
      problem: 'أنشئ متغيراً باسم "العمر" واحفظ فيه الرقم 25، ثم اطبعه.',
      availableBlocks: [
        CodeBlock(
          id: 'var_age',
          displayText: 'age = 25',
          codeValue: 'age = 25',
          type: CodeBlockType.variable,
        ),
        CodeBlock(
          id: 'var_name',
          displayText: 'name = "Ahmed"',
          codeValue: 'name = "Ahmed"',
          type: CodeBlockType.variable,
        ),
        CodeBlock(
          id: 'print_age',
          displayText: 'Print age',
          codeValue: 'print(age)',
          type: CodeBlockType.output,
        ),
        CodeBlock(
          id: 'print_name_var',
          displayText: 'Print name',
          codeValue: 'print(name)',
          type: CodeBlockType.output,
        ),
      ],
      correctSolution: ['age = 25', 'print(age)'],
      expectedOutput: '25',
      hint: 'أولاً أنشئ المتغير، ثم اطبعه',
      maxBlocks: 4,
      type: CodeChallengeType.variables,
    ),

    // Challenge 3: Simple Math
    CodeChallenge(
      id: 3,
      title: 'العمليات الحسابية',
      description: 'تعلم كيفية إجراء العمليات الحسابية البسيطة.',
      problem: 'احسب مجموع 10 + 15 واطبع النتيجة.',
      availableBlocks: [
        CodeBlock(
          id: 'result_var',
          displayText: 'result = 10 + 15',
          codeValue: 'result = 10 + 15',
          type: CodeBlockType.variable,
        ),
        CodeBlock(
          id: 'sub_20_5',
          displayText: '20 - 5',
          codeValue: '20 - 5',
          type: CodeBlockType.operation,
        ),
        CodeBlock(
          id: 'print_result',
          displayText: 'Print result',
          codeValue: 'print(result)',
          type: CodeBlockType.output,
        ),
      ],
      correctSolution: ['result = 10 + 15', 'print(result)'],
      expectedOutput: '25',
      hint: 'احفظ نتيجة الجمع في متغير، ثم اطبعها',
      maxBlocks: 3,
      type: CodeChallengeType.variables,
    ),

    // Challenge 4: Simple Loop
    CodeChallenge(
      id: 4,
      title: 'التكرار البسيط',
      description: 'تعلم كيفية استخدام التكرار لتنفيذ نفس العملية عدة مرات.',
      problem: 'اطبع الأرقام من 1 إلى 3.',
      availableBlocks: [
        CodeBlock(
          id: 'for_1_to_3',
          displayText: 'for i in range(1, 4)',
          codeValue: 'for i in range(1, 4):',
          type: CodeBlockType.loop,
        ),
        CodeBlock(
          id: 'for_1_to_5',
          displayText: 'for i in range(1, 6)',
          codeValue: 'for i in range(1, 6):',
          type: CodeBlockType.loop,
        ),
        CodeBlock(
          id: 'print_i',
          displayText: '    print(i)',
          codeValue: '    print(i)',
          type: CodeBlockType.output,
        ),
        CodeBlock(
          id: 'print_hello_loop',
          displayText: '    print("Hello")',
          codeValue: '    print("Hello")',
          type: CodeBlockType.output,
        ),
      ],
      correctSolution: ['for i in range(1, 4):', '    print(i)'],
      expectedOutput: '1\n2\n3',
      hint: 'استخدم حلقة التكرار من 1 إلى 3، ثم اطبع المتغير i',
      maxBlocks: 4,
      type: CodeChallengeType.loops,
    ),

    // Challenge 5: Condition
    CodeChallenge(
      id: 5,
      title: 'الشروط',
      description: 'تعلم كيفية استخدام الشروط لاتخاذ قرارات في البرنامج.',
      problem: 'إذا كان العمر أكبر من 18، اطبع "بالغ"، وإلا اطبع "قاصر".',
      availableBlocks: [
        CodeBlock(
          id: 'age_20',
          displayText: 'age = 20',
          codeValue: 'age = 20',
          type: CodeBlockType.variable,
        ),
        CodeBlock(
          id: 'age_15',
          displayText: 'age = 15',
          codeValue: 'age = 15',
          type: CodeBlockType.variable,
        ),
        CodeBlock(
          id: 'if_age_gt_18',
          displayText: 'if age > 18:',
          codeValue: 'if age > 18:',
          type: CodeBlockType.condition,
        ),
        CodeBlock(
          id: 'print_adult',
          displayText: '    print("Adult")',
          codeValue: '    print("Adult")',
          type: CodeBlockType.output,
        ),
        CodeBlock(
          id: 'else_block',
          displayText: 'else:',
          codeValue: 'else:',
          type: CodeBlockType.condition,
        ),
        CodeBlock(
          id: 'print_minor',
          displayText: '    print("Minor")',
          codeValue: '    print("Minor")',
          type: CodeBlockType.output,
        ),
      ],
      correctSolution: [
        'age = 20',
        'if age > 18:',
        '    print("Adult")',
        'else:',
        '    print("Minor")'
      ],
      expectedOutput: 'Adult',
      hint: 'أولاً حدد العمر، ثم استخدم الشرط للتحقق',
      maxBlocks: 8,
      type: CodeChallengeType.conditions,
    ),

    // Challenge 6: Function
    CodeChallenge(
      id: 6,
      title: 'الدوال',
      description: 'تعلم كيفية إنشاء دالة واستخدامها.',
      problem: 'أنشئ دالة تطبع "مرحبا" واستدعها.',
      availableBlocks: [
        CodeBlock(
          id: 'def_hello',
          displayText: 'def hello():',
          codeValue: 'def hello():',
          type: CodeBlockType.function,
        ),
        CodeBlock(
          id: 'def_goodbye',
          displayText: 'def goodbye():',
          codeValue: 'def goodbye():',
          type: CodeBlockType.function,
        ),
        CodeBlock(
          id: 'print_hello_func',
          displayText: '    print("Hello")',
          codeValue: '    print("Hello")',
          type: CodeBlockType.output,
        ),
        CodeBlock(
          id: 'call_hello',
          displayText: 'hello()',
          codeValue: 'hello()',
          type: CodeBlockType.function,
        ),
        CodeBlock(
          id: 'call_goodbye',
          displayText: 'goodbye()',
          codeValue: 'goodbye()',
          type: CodeBlockType.function,
        ),
      ],
      correctSolution: [
        'def hello():',
        '    print("Hello")',
        'hello()'
      ],
      expectedOutput: 'Hello',
      hint: 'أولاً عرّف الدالة، ثم استدعها',
      maxBlocks: 6,
      type: CodeChallengeType.functions,
    ),

    // Challenge 7: Complex Challenge
    CodeChallenge(
      id: 7,
      title: 'التحدي المتقدم',
      description: 'امزج جميع المفاهيم التي تعلمتها في تحدٍ واحد.',
      problem: 'أنشئ دالة تطبع الأرقام من 1 إلى رقم معين، واستدعها بالرقم 3.',
      availableBlocks: [
        CodeBlock(
          id: 'def_print_numbers',
          displayText: 'def print_numbers(n):',
          codeValue: 'def print_numbers(n):',
          type: CodeBlockType.function,
        ),
        CodeBlock(
          id: 'for_1_to_n',
          displayText: '    for i in range(1, n + 1):',
          codeValue: '    for i in range(1, n + 1):',
          type: CodeBlockType.loop,
        ),
        CodeBlock(
          id: 'print_i_func',
          displayText: '        print(i)',
          codeValue: '        print(i)',
          type: CodeBlockType.output,
        ),
        CodeBlock(
          id: 'call_print_numbers_3',
          displayText: 'print_numbers(3)',
          codeValue: 'print_numbers(3)',
          type: CodeBlockType.function,
        ),
        CodeBlock(
          id: 'call_print_numbers_5',
          displayText: 'print_numbers(5)',
          codeValue: 'print_numbers(5)',
          type: CodeBlockType.function,
        ),
      ],
      correctSolution: [
        'def print_numbers(n):',
        '    for i in range(1, n + 1):',
        '        print(i)',
        'print_numbers(3)'
      ],
      expectedOutput: '1\n2\n3',
      hint: 'عرّف دالة تأخذ معامل، استخدم حلقة تكرار، ثم استدعي الدالة',
      maxBlocks: 7,
      type: CodeChallengeType.mixed,
    ),
  ];

  static List<CodeChallenge> get allChallenges => _challenges;
  static int get totalChallenges => _challenges.length;

  static CodeChallenge? getChallenge(int id) {
    try {
      return _challenges.firstWhere((challenge) => challenge.id == id);
    } catch (e) {
      return null;
    }
  }

  static String executeCode(List<CodeBlock> blocks) {
    if (blocks.isEmpty) return '';

    List<String> codeLines = blocks.map((block) => block.codeValue).toList();
    String fullCode = codeLines.join('\n');

    return _simulateCodeExecution(fullCode);
  }

  static String _simulateCodeExecution(String code) {
    List<String> outputs = [];
    List<String> lines = code.split('\n');
    Map<String, dynamic> variables = {};
    Map<String, Function(List<String>)> functions = {};

    for (int index = 0; index < lines.length; index++) {
      String line = lines[index].trim();
      if (line.isEmpty) continue;

      // تعريف المتغيرات
      if (line.contains(' = ') && !line.startsWith('def ') && !line.startsWith('for ')) {
        List<String> parts = line.split(' = ');
        if (parts.length == 2) {
          String varName = parts[0].trim();
          String value = parts[1].trim();

          if (value.startsWith('"') && value.endsWith('"')) {
            variables[varName] = value.substring(1, value.length - 1);
          } else if (value.contains('+')) {
            List<String> addParts = value.split(' + ');
            if (addParts.length == 2) {
              int num1 = int.tryParse(addParts[0].trim()) ?? 0;
              int num2 = int.tryParse(addParts[1].trim()) ?? 0;
              variables[varName] = num1 + num2;
            }
          } else {
            variables[varName] = int.tryParse(value) ?? value;
          }
        }
      }

      // print
      else if (line.startsWith('print(')) {
        String content = line.substring(6, line.length - 1);
        if (content.startsWith('"') && content.endsWith('"')) {
          outputs.add(content.substring(1, content.length - 1));
        } else if (variables.containsKey(content)) {
          outputs.add(variables[content].toString());
        }
      }

      // for loop
      else if (line.startsWith('for ')) {
        List<String> loopBodyLines = [];
        int loopStart = index;
        // جمع جميع سطور الحلقة ذات المسافة البادئة
        for (int j = loopStart + 1; j < lines.length; j++) {
          if (lines[j].startsWith('    ')) {
            loopBodyLines.add(lines[j].substring(4));
          } else {
            break;
          }
        }

        String rangeStr = line.substring(line.indexOf('range(') + 6, line.indexOf(')'));
        List<String> rangeParts = rangeStr.split(',');
        int start = int.tryParse(rangeParts[0].trim()) ?? 1;
        int end;
        if (rangeParts[1].contains('+')) {
          String varPart = rangeParts[1].split('+')[0].trim();
          int plusVal = int.tryParse(rangeParts[1].split('+')[1].trim()) ?? 0;
          int varVal = variables.containsKey(varPart) ? variables[varPart] : int.tryParse(varPart) ?? 0;
          end = varVal + plusVal;
        } else {
          end = int.tryParse(rangeParts[1].trim()) ?? start;
        }

        for (int i = start; i < end; i++) {
          for (String loopLine in loopBodyLines) {
            loopLine = loopLine.trim();
            if (loopLine.startsWith('print(') && loopLine.endsWith(')')) {
              String content = loopLine.substring(6, loopLine.length - 1);
              if (content == 'i') {
                outputs.add(i.toString());
              } else if (variables.containsKey(content)) {
                outputs.add(variables[content].toString());
              } else if (content.startsWith('"') && content.endsWith('"')) {
                outputs.add(content.substring(1, content.length - 1));
              }
            }
          }
        }
      }

      // if statement
      else if (line.startsWith('if ')) {
        String condition = line.substring(3, line.length - 1);
        bool conditionResult = _evaluateCondition(condition, variables);

        int nextIndex = index + 1;
        if (conditionResult) {
          if (nextIndex < lines.length && lines[nextIndex].startsWith('    ') && lines[nextIndex].trim().startsWith('print(')) {
            String content = lines[nextIndex].trim().substring(6, lines[nextIndex].trim().length - 1);
            if (content.startsWith('"') && content.endsWith('"')) {
              outputs.add(content.substring(1, content.length - 1));
            } else if (variables.containsKey(content)) {
              outputs.add(variables[content].toString());
            }
          }
        } else {
          // البحث عن else
          for (int j = nextIndex; j < lines.length; j++) {
            if (lines[j].trim() == 'else:' && j + 1 < lines.length) {
              String elseLine = lines[j + 1].trim();
              if (elseLine.startsWith('print(') && elseLine.endsWith(')')) {
                String content = elseLine.substring(6, elseLine.length - 1);
                if (content.startsWith('"') && content.endsWith('"')) {
                  outputs.add(content.substring(1, content.length - 1));
                } else if (variables.containsKey(content)) {
                  outputs.add(variables[content].toString());
                }
              }
              break;
            }
          }
        }
      }
      // function definition and call can be expanded similarly
    }

    return outputs.join('\n');
  }

  static bool _evaluateCondition(String condition, Map<String, dynamic> variables) {
    if (condition.contains(' > ')) {
      List<String> parts = condition.split(' > ');
      if (parts.length == 2) {
        String leftVar = parts[0].trim();
        int rightValue = int.tryParse(parts[1].trim()) ?? 0;
        if (variables.containsKey(leftVar)) {
          int leftValue = variables[leftVar] as int? ?? 0;
          return leftValue > rightValue;
        }
      }
    }
    return false;
  }

  static bool checkSolution(CodeChallenge challenge, List<CodeBlock> selectedBlocks) {
    if (selectedBlocks.length != challenge.correctSolution.length) return false;
    for (int i = 0; i < selectedBlocks.length; i++) {
      if (selectedBlocks[i].codeValue != challenge.correctSolution[i]) return false;
    }
    return true;
  }
}
