import 'package:flutter/material.dart';
import '../../data/models/quiz_result.dart';
import '../../../../app/router.dart';

class ResultScreen extends StatelessWidget {
  final List<QuizResult> results;
  final String category;

  const ResultScreen({
    super.key,
    required this.results,
    required this.category,
  });

  Color get _categoryColor {
    switch (category) {
      case 'CS':
        return const Color(0xFF3B82F6);
      case 'iOS':
        return const Color(0xFF06B6D4);
      case 'Flutter':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 결과 요약
            _ResultHeader(
              category: category,
              totalCount: results.length,
              categoryColor: _categoryColor,
            ),

            // 결과 리스트
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: results.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _ResultCard(
                    index: index,
                    result: results[index],
                    categoryColor: _categoryColor,
                  );
                },
              ),
            ),

            // 하단 버튼
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1923),
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.06)),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.home,
                            (route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white.withOpacity(0.7),
                          side:
                              BorderSide(color: Colors.white.withOpacity(0.15)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          '홈으로',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.quiz,
                            arguments: category,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _categoryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          '다시 시험보기',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  final String category;
  final int totalCount;
  final Color categoryColor;

  const _ResultHeader({
    required this.category,
    required this.totalCount,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            categoryColor.withOpacity(0.15),
            categoryColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: categoryColor.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.emoji_events, color: categoryColor, size: 28),
          ),
          const SizedBox(height: 12),
          const Text(
            '퀴즈 완료!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$category · 총 $totalCount문제',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '아래에서 답변을 확인해보세요',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatefulWidget {
  final int index;
  final QuizResult result;
  final Color categoryColor;

  const _ResultCard({
    required this.index,
    required this.result,
    required this.categoryColor,
  });

  @override
  State<_ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<_ResultCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final question = widget.result.question;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A2634),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isExpanded
              ? widget.categoryColor.withOpacity(0.2)
              : Colors.white.withOpacity(0.06),
        ),
      ),
      child: Column(
        children: [
          // 헤더 (항상 표시)
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 번호
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: widget.categoryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.index + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: widget.categoryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 질문 + 난이도
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DifficultyBadge(difficulty: question.difficulty),
                        const SizedBox(height: 6),
                        Text(
                          question.question,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          maxLines: _isExpanded ? null : 2,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // 펼치기 아이콘
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white.withOpacity(0.4),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 펼쳐진 내용
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Divider(
                    color: Colors.white.withOpacity(0.06),
                    height: 1,
                  ),
                  const SizedBox(height: 16),

                  // 내 답변
                  _AnswerSection(
                    label: '내 답변',
                    icon: Icons.edit_note,
                    content: widget.result.userAnswer,
                    accentColor: const Color(0xFF3B82F6),
                  ),
                  const SizedBox(height: 12),

                  // 모범 답안
                  _AnswerSection(
                    label: '모범 답안',
                    icon: Icons.check_circle_outline,
                    content: question.sampleAnswer,
                    accentColor: const Color(0xFF22C55E),
                  ),
                  const SizedBox(height: 12),

                  // 키포인트
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withOpacity(0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFF59E0B).withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              size: 15,
                              color: const Color(0xFFF59E0B).withOpacity(0.8),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '키포인트',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFF59E0B).withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...question.keyPoints.map(
                          (point) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '•  ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white.withOpacity(0.65),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  final String difficulty;
  const _DifficultyBadge({required this.difficulty});

  Color get _color {
    switch (difficulty) {
      case 'easy':
        return const Color(0xFF22C55E);
      case 'medium':
        return const Color(0xFFF59E0B);
      case 'hard':
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  String get _label {
    switch (difficulty) {
      case 'easy':
        return 'EASY';
      case 'medium':
        return 'MEDIUM';
      case 'hard':
        return 'HARD';
      default:
        return difficulty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: _color,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _AnswerSection extends StatelessWidget {
  final String label;
  final IconData icon;
  final String content;
  final Color accentColor;

  const _AnswerSection({
    required this.label,
    required this.icon,
    required this.content,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: accentColor.withOpacity(0.8)),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: accentColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.65),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
