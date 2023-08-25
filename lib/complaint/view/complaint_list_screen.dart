import 'package:flutter/material.dart';
import 'package:kimgwajang/complaint/const/data.dart';

class ComplaintListScreen extends StatelessWidget {
  const ComplaintListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('민원처리'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(complaints[index].title),
                  children: [
                    ListTile(
                      title: Text('내용: ${complaints[index].content}'),
                    ),
                    ListTile(
                      title: Text('답변: ${complaints[index].reply}'),
                    ),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // 민원 작성 페이지로 이동하는 로직
              },
              child: const Text('민원 작성'),
            ),
          ),
        ],
      ),
    );
  }
}
