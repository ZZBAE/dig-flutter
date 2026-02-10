import 'question.dart';

class QuizResult {
  final Question question;
  final String userAnswer;

  QuizResult({
    required this.question,
    required this.userAnswer,
  });
}
