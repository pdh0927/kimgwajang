import 'package:flutter/material.dart';
import 'package:kimgwajang/complaint/component/complaint_card.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';

class ComplaintsList extends StatelessWidget {
  final List<Complaint> complaints;
  const ComplaintsList({super.key, required this.complaints});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return ComplaintCard(complaint: complaints[index]);
      },
    );
  }
}
