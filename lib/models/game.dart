class Game {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String category;
  final int difficulty; // 1-5
  final List<String> concepts;
  final bool isAvailable;
  final String? comingSoonMessage;

  const Game({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.difficulty,
    required this.concepts,
    this.isAvailable = true,
    this.comingSoonMessage,
  });

  static const List<Game> allGames = [
    Game(
      id: 'silent_teacher',
      title: 'Silent Teacher',
      description: 'لعبة بسيطة لاكتشاف مفاهيم البرمجة الأساسية بدون تعليمات صريحة. اكتشف القواعد من خلال التجربة والأخطاء.',
      imagePath: 'assets/images/silent_teacher_card.png',
      category: 'أساسيات البرمجة',
      difficulty: 2,
      concepts: ['الأنماط', 'التسلسل', 'المنطق الأساسي'],
      isAvailable: true,
    ),
    Game(
      id: 'compute_it',
      title: 'Compute It',
      description: 'نفذ البرامج كما يفعل الكمبيوتر. تعلم كيف يعمل الكمبيوتر خطوة بخطوة.',
      imagePath: 'assets/images/compute_it_card.png',
      category: 'تنفيذ البرامج',
      difficulty: 3,
      concepts: ['قراءة الكود', 'الاستراتيجية', 'التخطيط'],
      isAvailable: true,
    ),
    Game(
      id: 'code_n_slash',
      title: 'Code N Slash',
      description: 'قاتل الوحوش باستخدام الكود. لعبة أكشن مع البرمجة.',
      imagePath: 'assets/images/code_n_slash_card.png',
      category: 'أكشن وبرمجة',
      difficulty: 4,
      concepts: ['الحركة', 'الاستراتيجية', 'حل المشاكل'],
      isAvailable: true,
    ),
    Game(
      id: 'utopian_architect',
      title: 'Utopian Architect',
      description: 'ابن مدينة المستقبل بالبرمجة. تعلم التخطيط والبناء.',
      imagePath: 'assets/images/utopian_architect_card.png',
      category: 'بناء وتخطيط',
      difficulty: 4,
      concepts: ['التخطيط', 'البناء', 'الهندسة'],
      isAvailable: true,
    ),
    Game(
      id: 'paint_duel',
      title: 'Paint Duel',
      description: 'تحدى الذكاء الاصطناعي في معركة التلوين الاستراتيجية.',
      imagePath: 'assets/images/paint_duel_card.png',
      category: 'استراتيجية',
      difficulty: 5,
      concepts: ['قراءة الكود', 'الاستراتيجية', 'التخطيط'],
      isAvailable: true,
    ),
    Game(
      id: 'little_dot_adventure',
      title: 'Little Dot Adventure',
      description: 'نفذ الكود لحل المستويات واختر الحركات الصحيحة في كل دور. تعلم ميكانيكا البرمجة للمبتدئين.',
      imagePath: 'assets/images/little_dot_card.png',
      category: 'مغامرات البرمجة',
      difficulty: 2,
      concepts: ['تنفيذ الكود', 'اختيار الحركات', 'التخطيط المسبق'],
      isAvailable: true,
    ),
    Game(
      id: 'code_builder',
      title: 'Code Builder',
      description: 'ابن الكود خطوة بخطوة باستخدام كتل البرمجة. تعلم المفاهيم الأساسية للبرمجة بطريقة تفاعلية.',
      imagePath: 'assets/images/code_builder_card.png',
      category: 'بناء الكود',
      difficulty: 3,
      concepts: ['المتغيرات', 'الدوال', 'التكرار', 'الشروط'],
      isAvailable: true,
    ),
  ];

  static List<Game> getAvailableGames() {
    return allGames.where((game) => game.isAvailable).toList();
  }

  static List<Game> getComingSoonGames() {
    return allGames.where((game) => !game.isAvailable).toList();
  }

  static Game? getGameById(String id) {
    try {
      return allGames.firstWhere((game) => game.id == id);
    } catch (e) {
      return null;
    }
  }
}

