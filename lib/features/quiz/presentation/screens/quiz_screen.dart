import 'package:flutter/material.dart';
import '../../data/sources/local_question_source.dart';
import '../../data/models/question.dart';
import '../../data/models/quiz_result.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;
  final _answerController = TextEditingController();
  final List<QuizResult> _results = [];
  bool _isLoading = true;
  String _category = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      final category =
          ModalRoute.of(context)?.settings.arguments as String? ?? 'CS';
      _category = category;
      _loadQuestions(category);
    }
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestions(String category) async {
    final questions =
        await LocalQuestionSource().getQuestionsByCategory(category);
    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }

  void _submitAnswer() {
    final answer = _answerController.text.trim();

    _results.add(QuizResult(
      question: _questions[_currentIndex],
      userAnswer: answer.isEmpty ? '(미작성)' : answer,
    ));

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _answerController.clear();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            results: _results,
            category: _category,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('$_category ${_currentIndex + 1} / ${_questions.length}'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 진행률 바
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _questions.length,
                  minHeight: 6,
                  backgroundColor: Colors.grey.shade200,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.black87),
                ),
              ),
              const SizedBox(height: 20),

              // 난이도
              _DifficultyTag(difficulty: question.difficulty),
              const SizedBox(height: 12),

              // 질문
              Text(
                question.question,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // 답변 입력칸
              TextField(
                controller: _answerController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: '여기에 답변을 작성해보세요...',
                  hintStyle: const TextStyle(color: Colors.black38),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.black87, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 제출 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentIndex < _questions.length - 1
                        ? '제출 후 다음 질문'
                        : '제출 후 결과 보기',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DifficultyTag extends StatelessWidget {
  final String difficulty;
  const _DifficultyTag({required this.difficulty});

  Color get _color {
    switch (difficulty) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String get _label {
    switch (difficulty) {
      case 'easy':
        return '쉬움';
      case 'medium':
        return '보통';
      case 'hard':
        return '어려움';
      default:
        return difficulty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _color.withOpacity(0.3)),
      ),
      child: Text(
        _label,
        style:
            TextStyle(fontSize: 12, color: _color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
