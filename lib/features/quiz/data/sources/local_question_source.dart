import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/question.dart';

class LocalQuestionSource {
  static const Map<String, String> _categoryFiles = {
    'CS': 'assets/data/cs.json',
    'iOS': 'assets/data/ios.json',
    'Flutter': 'assets/data/flutter.json',
  };

  Future<List<Question>> getQuestionsByCategory(String category) async {
    final path = _categoryFiles[category];
    if (path == null) throw Exception('Unknown category: $category');

    final jsonString = await rootBundle.loadString(path);
    final List<dynamic> jsonList = json.decode(jsonString);
    final questions = jsonList.map((e) => Question.fromJson(e)).toList();
    questions.shuffle(Random());
    return questions;
  }

  Future<List<Question>> getAllQuestions() async {
    final List<Question> allQuestions = [];
    for (final path in _categoryFiles.values) {
      final jsonString = await rootBundle.loadString(path);
      final List<dynamic> jsonList = json.decode(jsonString);
      allQuestions.addAll(jsonList.map((e) => Question.fromJson(e)));
    }
    allQuestions.shuffle(Random());
    return allQuestions;
  }
}
