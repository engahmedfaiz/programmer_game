import '../models/compute_challenge.dart';

class ComputeChallengesData {
  static const List<ComputeChallenge> _challenges = [
    // Challenge 1: Simple Variable Assignment
    ComputeChallenge(
      id: 1,
      title: 'تعيين المتغيرات',
      description: 'تعلم كيف يقوم الكمبيوتر بحفظ القيم في المتغيرات.',
      code: '''x = 5
y = 10
z = x + y
print(z)''',
      steps: [
        ComputeStep(
          stepNumber: 1,
          instruction: 'تعيين القيمة 5 للمتغير x',
          codeSnippet: 'x = 5',
          variablesBefore: {},
          variablesAfter: {'x': 5},
          type: ComputeStepType.assignment,
          explanation: 'يحفظ الكمبيوتر القيمة 5 في الذاكرة تحت اسم x',
        ),
        ComputeStep(
          stepNumber: 2,
          instruction: 'تعيين القيمة 10 للمتغير y',
          codeSnippet: 'y = 10',
          variablesBefore: {'x': 5},
          variablesAfter: {'x': 5, 'y': 10},
          type: ComputeStepType.assignment,
          explanation: 'يحفظ الكمبيوتر القيمة 10 في الذاكرة تحت اسم y',
        ),
        ComputeStep(
          stepNumber: 3,
          instruction: 'حساب مجموع x + y وحفظه في z',
          codeSnippet: 'z = x + y',
          variablesBefore: {'x': 5, 'y': 10},
          variablesAfter: {'x': 5, 'y': 10, 'z': 15},
          type: ComputeStepType.calculation,
          explanation: 'يجمع الكمبيوتر قيمة x (5) مع قيمة y (10) ويحفظ النتيجة (15) في z',
        ),
        ComputeStep(
          stepNumber: 4,
          instruction: 'طباعة قيمة z',
          codeSnippet: 'print(z)',
          variablesBefore: {'x': 5, 'y': 10, 'z': 15},
          variablesAfter: {'x': 5, 'y': 10, 'z': 15},
          output: '15',
          type: ComputeStepType.output,
          explanation: 'يطبع الكمبيوتر قيمة المتغير z وهي 15',
        ),
      ],
      initialVariables: {},
      expectedOutput: '15',
      hint: 'تابع كل خطوة بعناية وراقب كيف تتغير قيم المتغيرات',
      type: ComputeChallengeType.variables,
    ),

    // Challenge 2: Arithmetic Operations
    ComputeChallenge(
      id: 2,
      title: 'العمليات الحسابية',
      description: 'تعلم كيف يقوم الكمبيوتر بإجراء العمليات الحسابية.',
      code: '''a = 8
b = 3
sum = a + b
diff = a - b
product = a * b
print(sum)
print(diff)
print(product)''',
      steps: [
        ComputeStep(
          stepNumber: 1,
          instruction: 'تعيين القيمة 8 للمتغير a',
          codeSnippet: 'a = 8',
          variablesBefore: {},
          variablesAfter: {'a': 8},
          type: ComputeStepType.assignment,
          explanation: 'يحفظ الكمبيوتر القيمة 8 في المتغير a',
        ),
        ComputeStep(
          stepNumber: 2,
          instruction: 'تعيين القيمة 3 للمتغير b',
          codeSnippet: 'b = 3',
          variablesBefore: {'a': 8},
          variablesAfter: {'a': 8, 'b': 3},
          type: ComputeStepType.assignment,
          explanation: 'يحفظ الكمبيوتر القيمة 3 في المتغير b',
        ),
        ComputeStep(
          stepNumber: 3,
          instruction: 'حساب مجموع a + b',
          codeSnippet: 'sum = a + b',
          variablesBefore: {'a': 8, 'b': 3},
          variablesAfter: {'a': 8, 'b': 3, 'sum': 11},
          type: ComputeStepType.calculation,
          explanation: 'يجمع الكمبيوتر 8 + 3 = 11 ويحفظ النتيجة في sum',
        ),
        ComputeStep(
          stepNumber: 4,
          instruction: 'حساب الفرق a - b',
          codeSnippet: 'diff = a - b',
          variablesBefore: {'a': 8, 'b': 3, 'sum': 11},
          variablesAfter: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5},
          type: ComputeStepType.calculation,
          explanation: 'يطرح الكمبيوتر 8 - 3 = 5 ويحفظ النتيجة في diff',
        ),
        ComputeStep(
          stepNumber: 5,
          instruction: 'حساب الضرب a * b',
          codeSnippet: 'product = a * b',
          variablesBefore: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5},
          variablesAfter: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5, 'product': 24},
          type: ComputeStepType.calculation,
          explanation: 'يضرب الكمبيوتر 8 × 3 = 24 ويحفظ النتيجة في product',
        ),
        ComputeStep(
          stepNumber: 6,
          instruction: 'طباعة قيمة sum',
          codeSnippet: 'print(sum)',
          variablesBefore: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5, 'product': 24},
          variablesAfter: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5, 'product': 24},
          output: '11',
          type: ComputeStepType.output,
          explanation: 'يطبع الكمبيوتر قيمة sum وهي 11',
        ),
        ComputeStep(
          stepNumber: 7,
          instruction: 'طباعة قيمة diff',
          codeSnippet: 'print(diff)',
          variablesBefore: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5, 'product': 24},
          variablesAfter: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5, 'product': 24},
          output: '5',
          type: ComputeStepType.output,
          explanation: 'يطبع الكمبيوتر قيمة diff وهي 5',
        ),
        ComputeStep(
          stepNumber: 8,
          instruction: 'طباعة قيمة product',
          codeSnippet: 'print(product)',
          variablesBefore: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5, 'product': 24},
          variablesAfter: {'a': 8, 'b': 3, 'sum': 11, 'diff': 5, 'product': 24},
          output: '24',
          type: ComputeStepType.output,
          explanation: 'يطبع الكمبيوتر قيمة product وهي 24',
        ),
      ],
      initialVariables: {},
      expectedOutput: '11\n5\n24',
      hint: 'راقب كيف يحسب الكمبيوتر كل عملية ويحفظ النتيجة',
      type: ComputeChallengeType.arithmetic,
    ),

    // Challenge 3: Simple Condition
    ComputeChallenge(
      id: 3,
      title: 'الشروط البسيطة',
      description: 'تعلم كيف يتخذ الكمبيوتر القرارات باستخدام الشروط.',
      code: '''age = 20
if age >= 18:
    print("بالغ")
else:
    print("قاصر")''',
      steps: [
        ComputeStep(
          stepNumber: 1,
          instruction: 'تعيين القيمة 20 للمتغير age',
          codeSnippet: 'age = 20',
          variablesBefore: {},
          variablesAfter: {'age': 20},
          type: ComputeStepType.assignment,
          explanation: 'يحفظ الكمبيوتر القيمة 20 في المتغير age',
        ),
        ComputeStep(
          stepNumber: 2,
          instruction: 'فحص الشرط: هل age >= 18؟',
          codeSnippet: 'if age >= 18:',
          variablesBefore: {'age': 20},
          variablesAfter: {'age': 20},
          type: ComputeStepType.condition,
          explanation: 'يفحص الكمبيوتر: هل 20 >= 18؟ النتيجة: صحيح (True)',
        ),
        ComputeStep(
          stepNumber: 3,
          instruction: 'تنفيذ الكود داخل if لأن الشرط صحيح',
          codeSnippet: 'print("بالغ")',
          variablesBefore: {'age': 20},
          variablesAfter: {'age': 20},
          output: 'بالغ',
          type: ComputeStepType.output,
          explanation: 'لأن الشرط صحيح، ينفذ الكمبيوتر الكود داخل if ويطبع "بالغ"',
        ),
      ],
      initialVariables: {},
      expectedOutput: 'بالغ',
      hint: 'راقب كيف يفحص الكمبيوتر الشرط ويقرر أي كود ينفذ',
      type: ComputeChallengeType.conditions,
    ),

    // Challenge 4: Simple Loop
    ComputeChallenge(
      id: 4,
      title: 'التكرار البسيط',
      description: 'تعلم كيف يكرر الكمبيوتر تنفيذ نفس الكود عدة مرات.',
      code: '''for i in range(3):
    print(i)''',
      steps: [
        ComputeStep(
          stepNumber: 1,
          instruction: 'بداية الحلقة: i = 0',
          codeSnippet: 'for i in range(3): # i = 0',
          variablesBefore: {},
          variablesAfter: {'i': 0},
          type: ComputeStepType.loop,
          explanation: 'يبدأ الكمبيوتر الحلقة ويعطي i القيمة 0',
        ),
        ComputeStep(
          stepNumber: 2,
          instruction: 'طباعة قيمة i (0)',
          codeSnippet: 'print(i) # i = 0',
          variablesBefore: {'i': 0},
          variablesAfter: {'i': 0},
          output: '0',
          type: ComputeStepType.output,
          explanation: 'يطبع الكمبيوتر قيمة i وهي 0',
        ),
        ComputeStep(
          stepNumber: 3,
          instruction: 'التكرار الثاني: i = 1',
          codeSnippet: 'for i in range(3): # i = 1',
          variablesBefore: {'i': 0},
          variablesAfter: {'i': 1},
          type: ComputeStepType.loop,
          explanation: 'يزيد الكمبيوتر قيمة i إلى 1 ويكرر الحلقة',
        ),
        ComputeStep(
          stepNumber: 4,
          instruction: 'طباعة قيمة i (1)',
          codeSnippet: 'print(i) # i = 1',
          variablesBefore: {'i': 1},
          variablesAfter: {'i': 1},
          output: '1',
          type: ComputeStepType.output,
          explanation: 'يطبع الكمبيوتر قيمة i وهي 1',
        ),
        ComputeStep(
          stepNumber: 5,
          instruction: 'التكرار الثالث: i = 2',
          codeSnippet: 'for i in range(3): # i = 2',
          variablesBefore: {'i': 1},
          variablesAfter: {'i': 2},
          type: ComputeStepType.loop,
          explanation: 'يزيد الكمبيوتر قيمة i إلى 2 ويكرر الحلقة',
        ),
        ComputeStep(
          stepNumber: 6,
          instruction: 'طباعة قيمة i (2)',
          codeSnippet: 'print(i) # i = 2',
          variablesBefore: {'i': 2},
          variablesAfter: {'i': 2},
          output: '2',
          type: ComputeStepType.output,
          explanation: 'يطبع الكمبيوتر قيمة i وهي 2',
        ),
        ComputeStep(
          stepNumber: 7,
          instruction: 'انتهاء الحلقة',
          codeSnippet: '# انتهت الحلقة',
          variablesBefore: {'i': 2},
          variablesAfter: {'i': 2},
          type: ComputeStepType.loop,
          explanation: 'وصل i إلى 3، لذا تنتهي الحلقة',
        ),
      ],
      initialVariables: {},
      expectedOutput: '0\n1\n2',
      hint: 'راقب كيف تتغير قيمة i في كل تكرار',
      type: ComputeChallengeType.loops,
    ),

    // Challenge 5: Function Call
    ComputeChallenge(
      id: 5,
      title: 'استدعاء الدوال',
      description: 'تعلم كيف يستدعي الكمبيوتر الدوال وينفذها.',
      code: '''def greet(name):
    return "مرحبا " + name

result = greet("أحمد")
print(result)''',
      steps: [
        ComputeStep(
          stepNumber: 1,
          instruction: 'تعريف الدالة greet',
          codeSnippet: 'def greet(name):',
          variablesBefore: {},
          variablesAfter: {},
          type: ComputeStepType.function,
          explanation: 'يحفظ الكمبيوتر تعريف الدالة greet في الذاكرة',
        ),
        ComputeStep(
          stepNumber: 2,
          instruction: 'استدعاء الدالة greet مع المعامل "أحمد"',
          codeSnippet: 'result = greet("أحمد")',
          variablesBefore: {},
          variablesAfter: {'name': 'أحمد'},
          type: ComputeStepType.function,
          explanation: 'يستدعي الكمبيوتر الدالة greet ويمرر "أحمد" كمعامل',
        ),
        ComputeStep(
          stepNumber: 3,
          instruction: 'تنفيذ كود الدالة: ربط النصوص',
          codeSnippet: 'return "مرحبا " + name',
          variablesBefore: {'name': 'أحمد'},
          variablesAfter: {'name': 'أحمد', 'result': 'مرحبا أحمد'},
          type: ComputeStepType.calculation,
          explanation: 'يربط الكمبيوتر "مرحبا " مع "أحمد" ويعيد "مرحبا أحمد"',
        ),
        ComputeStep(
          stepNumber: 4,
          instruction: 'حفظ نتيجة الدالة في result',
          codeSnippet: '# result = "مرحبا أحمد"',
          variablesBefore: {'result': 'مرحبا أحمد'},
          variablesAfter: {'result': 'مرحبا أحمد'},
          type: ComputeStepType.assignment,
          explanation: 'يحفظ الكمبيوتر نتيجة الدالة في المتغير result',
        ),
        ComputeStep(
          stepNumber: 5,
          instruction: 'طباعة قيمة result',
          codeSnippet: 'print(result)',
          variablesBefore: {'result': 'مرحبا أحمد'},
          variablesAfter: {'result': 'مرحبا أحمد'},
          output: 'مرحبا أحمد',
          type: ComputeStepType.output,
          explanation: 'يطبع الكمبيوتر قيمة result وهي "مرحبا أحمد"',
        ),
      ],
      initialVariables: {},
      expectedOutput: 'مرحبا أحمد',
      hint: 'راقب كيف ينتقل الكمبيوتر إلى داخل الدالة ثم يعود',
      type: ComputeChallengeType.functions,
    ),
  ];

  static List<ComputeChallenge> get allChallenges => _challenges;
  static int get totalChallenges => _challenges.length;

  static ComputeChallenge? getChallenge(int id) {
    try {
      return _challenges.firstWhere((challenge) => challenge.id == id);
    } catch (e) {
      return null;
    }
  }

  static bool checkStepAnswer(ComputeStep step, Map<String, dynamic> userVariables, String? userOutput) {
    // Check variables
    for (String key in step.variablesAfter.keys) {
      if (!userVariables.containsKey(key) || userVariables[key] != step.variablesAfter[key]) {
        return false;
      }
    }

    // Check output if expected
    if (step.output != null) {
      return userOutput == step.output;
    }

    return true;
  }

  static String getStepTypeIcon(ComputeStepType type) {
    switch (type) {
      case ComputeStepType.assignment:
        return '📝';
      case ComputeStepType.calculation:
        return '🧮';
      case ComputeStepType.output:
        return '📺';
      case ComputeStepType.condition:
        return '🤔';
      case ComputeStepType.loop:
        return '🔄';
      case ComputeStepType.function:
        return '⚙️';
    }
  }

  static String getStepTypeDescription(ComputeStepType type) {
    switch (type) {
      case ComputeStepType.assignment:
        return 'تعيين قيمة';
      case ComputeStepType.calculation:
        return 'حساب';
      case ComputeStepType.output:
        return 'إخراج';
      case ComputeStepType.condition:
        return 'شرط';
      case ComputeStepType.loop:
        return 'تكرار';
      case ComputeStepType.function:
        return 'دالة';
    }
  }
}

