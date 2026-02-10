import 'package:flutter/material.dart';
import '../../data/sources/local_question_source.dart';
import '../../data/models/question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Question? _question;
  final _source = LocalQuestionSource();
  final _answerController = TextEditingController();
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestion() async {
    final q = await _source.getRandomQuestion();
    setState(() {
      _question = q;
      _answerController.clear();
      _showAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('랜덤 질문')),
      body: _question == null
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _question!.category,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _question!.question,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),

                    // 답변 입력칸
                    TextField(
                      controller: _answerController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: '여기에 답변을 작성해보세요...',
                        hintStyle: const TextStyle(color: Colors.black38),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.black87, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 정답 보기 버튼
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showAnswer = !_showAnswer;
                          });
                        },
                        icon: Icon(
                          _showAnswer ? Icons.visibility_off : Icons.visibility,
                          size: 18,
                        ),
                        label: Text(_showAnswer ? '정답 숨기기' : '정답 보기'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    // 정답 영역
                    if (_showAnswer) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '📌 키포인트',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            ...(_question!.keyPoints.map(
                              (point) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '• $point',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )),
                            const SizedBox(height: 12),
                            const Text(
                              '✅ 모범 답안',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _question!.sampleAnswer,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // 다음 질문 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loadQuestion,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('다음 질문'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
