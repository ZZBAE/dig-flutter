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
              '카테고리를 선택하고\n면접 질문에 답변해보세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _CategoryCard(
              title: 'CS',
              subtitle: '운영체제, 네트워크, 자료구조, DB',
              icon: Icons.computer,
              color: Colors.blue,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.quiz,
                arguments: 'CS',
              ),
            ),
            const SizedBox(height: 12),
            _CategoryCard(
              title: 'iOS',
              subtitle: 'Swift, UIKit, SwiftUI, 메모리 관리',
              icon: Icons.phone_iphone,
              color: Colors.orange,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.quiz,
                arguments: 'iOS',
              ),
            ),
            const SizedBox(height: 12),
            _CategoryCard(
              title: 'Flutter',
              subtitle: 'Widget, 상태관리, Dart, 렌더링',
              icon: Icons.flutter_dash,
              color: Colors.teal,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.quiz,
                arguments: 'Flutter',
              ),
            ),
            const Spacer(),
            const Text(
              'v0.2 • 카테고리별 20문제 (총 60문제)',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
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
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
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
            Text(
              '20문제',
              style: TextStyle(fontSize: 12, color: Colors.black38),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
