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
      body: const Column(
        children: [
          Expanded(child: ComplaintsList()),
        ],
      ),
    );
  }
}
