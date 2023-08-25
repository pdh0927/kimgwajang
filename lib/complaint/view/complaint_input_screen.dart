import 'package:flutter/material.dart';

class ComplaintInputScreen extends StatefulWidget {
  const ComplaintInputScreen({super.key});

  @override
  _ComplaintInputScreenState createState() => _ComplaintInputScreenState();
}

class _ComplaintInputScreenState extends State<ComplaintInputScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('민원 입력하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '카테고리 걱정없이 편하게 민원을 넣으세요 :)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            // 추가적으로 필요한 버튼 및 기능들을 여기에 구현하면 됩니다.
          ],
        ),
      ),
    );
  }
}
