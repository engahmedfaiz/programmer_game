class Level {
  final int id;
  final String challengeType;
  final String question;
  final String expectedAnswer;
  final String feedbackCorrect;
  final String feedbackIncorrect;
  final String hint;

  Level({
    required this.id,
    required this.challengeType,
    required this.question,
    required this.expectedAnswer,
    required this.feedbackCorrect,
    required this.feedbackIncorrect,
    required this.hint,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      challengeType: json['challenge_type'],
      question: json['question'],
      expectedAnswer: json['expected_answer'],
      feedbackCorrect: json['feedback_correct'],
      feedbackIncorrect: json['feedback_incorrect'],
      hint: json['hint'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'challenge_type': challengeType,
      'question': question,
      'expected_answer': expectedAnswer,
      'feedback_correct': feedbackCorrect,
      'feedback_incorrect': feedbackIncorrect,
      'hint': hint,
    };
  }
}

