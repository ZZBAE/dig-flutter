import 'package:flutter/material.dart';
import '../../../../app/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dev Interview Gym')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              '랜덤 질문으로 답변 연습하고\n키포인트로 반복 학습하세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _MenuButton(
              title: '랜덤 질문 시작',
              subtitle: 'CS 중심 + Flutter/iOS 보조',
              onTap: () => Navigator.pushNamed(context, AppRoutes.quiz),
            ),
            const SizedBox(height: 12),
            _MenuButton(
              title: '오답노트',
              subtitle: '다시 볼 문제 모아보기',
              onTap: () => Navigator.pushNamed(context, AppRoutes.retry),
            ),
            const SizedBox(height: 12),
            _MenuButton(
              title: '즐겨찾기',
              subtitle: '자주 보는 질문 저장',
              onTap: () => Navigator.pushNamed(context, AppRoutes.favorites),
            ),
            const Spacer(),
            const Text(
              'v0.1 • Local JSON 기반 (추후 Hive/Railway 확장)',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuButton({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            const Icon(Icons.fitness_center),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
