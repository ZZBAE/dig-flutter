class Question {
  final int id;
  final String category;
  final String difficulty;
  final String question;
  final List<String> keyPoints;
  final String sampleAnswer;

  Question({
    required this.id,
    required this.category,
    required this.difficulty,
    required this.question,
    required this.keyPoints,
    required this.sampleAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      category: json['category'],
      difficulty: json['difficulty'],
      question: json['question'],
      keyPoints: List<String>.from(json['keyPoints']),
      sampleAnswer: json['sampleAnswer'],
    );
  }
}
