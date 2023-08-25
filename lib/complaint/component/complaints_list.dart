import 'package:flutter/material.dart';
import 'package:kimgwajang/complaint/const/data.dart';

class ComplaintsList extends StatelessWidget {
  const ComplaintsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
