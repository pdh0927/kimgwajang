import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/component/complaint_card.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';

class ComplaintsList extends ConsumerWidget {
  const ComplaintsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ComplaintModel> complaints = ref.watch(complaintstListProvider);

    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return ComplaintCard(complaint: complaints[index]);
      },
    );
  }
}
