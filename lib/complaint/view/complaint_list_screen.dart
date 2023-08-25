import 'package:flutter/material.dart';
import 'package:kimgwajang/complaint/component/complaints_list.dart';

class ComplaintListScreen extends StatelessWidget {
  const ComplaintListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 민원 목록'),
      ),
      body: Column(
        children: [
          const Expanded(child: ComplaintsList()),
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
