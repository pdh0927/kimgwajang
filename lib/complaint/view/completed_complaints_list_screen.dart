import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/component/complaints_list.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';

class CompletedComplaintsListScreen extends ConsumerWidget {
  const CompletedComplaintsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ComplaintModel> complaints =
        ref.watch(completedComplaintstListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '처리된 민원 목록',
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
