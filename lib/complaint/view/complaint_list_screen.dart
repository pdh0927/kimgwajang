import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/component/complaints_list.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';

class ComplaintListScreen extends ConsumerWidget {
  const ComplaintListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Complaint> complaints = ref.watch(uncompletedComplaintstListProvider) +
        ref.watch(completedComplaintstListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '나의 민원 목록',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: ComplaintsList(complaints: complaints)),
        ],
      ),
    );
  }
}
