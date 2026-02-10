import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/question.dart';

class LocalQuestionSource {
  Future<List<Question>> getAllQuestions() async {
    final jsonString =
        await rootBundle.loadString('assets/data/questions.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final questions = jsonList.map((e) => Question.fromJson(e)).toList();
    questions.shuffle(Random());
    return questions;
  }

  Future<Question> getRandomQuestion() async {
    final questions = await getAllQuestions();
    final randomIndex = Random().nextInt(questions.length);
    return questions[randomIndex];
  }
}
