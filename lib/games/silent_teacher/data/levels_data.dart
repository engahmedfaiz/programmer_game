import '../models/level.dart';

class LevelsData {
  static final List<Level> levels = [
    // المرحلة الأولى: الأنماط الرقمية البسيطة
    Level(
      id: 1,
      challengeType: "sequence",
      question: "1, 2, 3, ?",
      expectedAnswer: "4",
      feedbackCorrect: "أحسنت! اكتشفت النمط.",
      feedbackIncorrect: "حاول مرة أخرى. فكر في النمط.",
      hint: "ما هو الرقم التالي في التسلسل؟",
    ),
    Level(
      id: 2,
      challengeType: "sequence",
      question: "2, 4, 6, ?",
      expectedAnswer: "8",
      feedbackCorrect: "ممتاز! الأرقام الزوجية.",
      feedbackIncorrect: "فكر في الأرقام الزوجية.",
      hint: "كل رقم يزيد بمقدار 2",
    ),
    Level(
      id: 3,
      challengeType: "sequence",
      question: "5, 10, 15, ?",
      expectedAnswer: "20",
      feedbackCorrect: "رائع! جدول الضرب في 5.",
      feedbackIncorrect: "انظر إلى الفرق بين الأرقام.",
      hint: "كل رقم يزيد بمقدار 5",
    ),
    Level(
      id: 4,
      challengeType: "sequence",
      question: "1, 1, 2, 3, 5, ?",
      expectedAnswer: "8",
      feedbackCorrect: "ممتاز! متتالية فيبوناتشي.",
      feedbackIncorrect: "فكر في علاقة كل رقم بالرقمين السابقين.",
      hint: "كل رقم هو مجموع الرقمين السابقين",
    ),
    // المرحلة الثانية: الأنماط الحرفية
    Level(
      id: 5,
      challengeType: "sequence",
      question: "A, B, C, ?",
      expectedAnswer: "D",
      feedbackCorrect: "ممتاز! الأبجدية الإنجليزية.",
      feedbackIncorrect: "فكر في ترتيب الحروف الأبجدية.",
      hint: "الحرف التالي في الأبجدية",
    ),
    Level(
      id: 6,
      challengeType: "sequence",
      question: "A, C, E, ?",
      expectedAnswer: "G",
      feedbackCorrect: "رائع! الحروف المتباعدة.",
      feedbackIncorrect: "انظر إلى المسافة بين الحروف.",
      hint: "نتخطى حرف واحد في كل مرة",
    ),
    // المرحلة الثالثة: الأنماط المختلطة
    Level(
      id: 7,
      challengeType: "pattern",
      question: "1, A, 2, B, 3, ?",
      expectedAnswer: "C",
      feedbackCorrect: "ممتاز! نمط مختلط من الأرقام والحروف.",
      feedbackIncorrect: "فكر في النمطين المتداخلين.",
      hint: "رقم، حرف، رقم، حرف...",
    ),
    Level(
      id: 8,
      challengeType: "arithmetic",
      question: "2 + 2 = ?",
      expectedAnswer: "4",
      feedbackCorrect: "صحيح! عملية جمع بسيطة.",
      feedbackIncorrect: "حاول مرة أخرى.",
      hint: "جمع رقمين متساويين",
    ),
    Level(
      id: 9,
      challengeType: "arithmetic",
      question: "3 × 3 = ?",
      expectedAnswer: "9",
      feedbackCorrect: "ممتاز! عملية ضرب.",
      feedbackIncorrect: "فكر في جدول الضرب.",
      hint: "3 مضروب في نفسه",
    ),
    Level(
      id: 10,
      challengeType: "logic",
      question: "إذا كان A = 1، B = 2، فإن C = ?",
      expectedAnswer: "3",
      feedbackCorrect: "رائع! اكتشفت العلاقة بين الحروف والأرقام.",
      feedbackIncorrect: "فكر في موقع الحرف في الأبجدية.",
      hint: "كل حرف يمثل رقم موقعه في الأبجدية",
    ),
  ];

  static int get totalLevels => levels.length;

  static Level? getLevel(int id) {
    try {
      return levels.firstWhere((level) => level.id == id);
    } catch (e) {
      return null;
    }
  }

  static Level? getNextLevel(int currentId) {
    try {
      return levels.firstWhere((level) => level.id == currentId + 1);
    } catch (e) {
      return null;
    }
  }
}

