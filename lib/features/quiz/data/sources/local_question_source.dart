import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/question.dart';

class LocalQuestionSource {
  Future<Question> getRandomQuestion() async {
    final jsonString =
        await rootBundle.loadString('assets/data/questions.json');

    final List<dynamic> jsonList = json.decode(jsonString);

    final List<Question> questions =
        jsonList.map((e) => Question.fromJson(e)).toList();

    final randomIndex = Random().nextInt(questions.length);
    return questions[randomIndex];
  }
}
