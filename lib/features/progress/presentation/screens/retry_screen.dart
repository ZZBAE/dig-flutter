import 'package:flutter/material.dart';

class RetryScreen extends StatelessWidget {
  const RetryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('오답노트')),
      body: Center(child: Text('다시 볼 질문 목록')),
    );
  }
}
