import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';

class ComplaintCard extends ConsumerWidget {
  final ComplaintModel complaint;

  const ComplaintCard({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String statusLabel = complaint.reply.isEmpty ? '처리중' : '처리 완료';
    Color labelColor = complaint.reply.isEmpty ? Colors.grey : Colors.green;

    return ExpansionTile(
      title: Row(
        children: [
          Container(
            width: 80,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: labelColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(statusLabel,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(complaint.title)),
        ],
      ),
      children: [
        ListTile(title: Text('내용: ${complaint.content}')),
        if (complaint.imagePath != '')
          Image.file(
            File(complaint.imagePath),
            width: 125,
            height: 125,
            fit: BoxFit.fill,
          ),
        ListTile(title: Text('답변: ${complaint.reply}')),
        complaint.evaluation != null
            ? ListTile(
                title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildStars(complaint.evaluation),
              ))
            : ListTile(
                title: ElevatedButton(
                onPressed: () {
                  _showRatingOptions(context, complaint, ref);
                },
                child: const Text('답변 평가하기'),
              )),
      ],
    );
  }

  List<Widget> _buildStars(int? evaluation) {
    List<Widget> stars = [const Text('답변 만족도 : ')];
    for (var i = 0; i < 5; i++) {
      stars.add(Icon(
        i < (evaluation ?? 0) ? Icons.star : Icons.star_border,
        color: Colors.yellow,
      ));
    }
    return stars;
  }

  void _showRatingOptions(
      BuildContext context, ComplaintModel complaint, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('답변 평가하기'),
          titlePadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(5),
          actionsPadding: const EdgeInsets.all(10),
          content: SizedBox(
            height: 220,
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildRatingOption(context, ref, '매우 만족', complaint, 5),
                const Divider(thickness: 1, height: 0),
                _buildRatingOption(context, ref, '대체로 만족', complaint, 4),
                const Divider(thickness: 1, height: 0),
                _buildRatingOption(context, ref, '보통', complaint, 3),
                const Divider(thickness: 1, height: 0),
                _buildRatingOption(context, ref, '대체로 불만족', complaint, 2),
                const Divider(thickness: 1, height: 0),
                _buildRatingOption(context, ref, '불만족', complaint, 1),
                const Divider(thickness: 1, height: 0),
                _buildRatingOption(context, ref, '매우 불만족', complaint, 0),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
              ),
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRatingOption(BuildContext context, WidgetRef ref, String title,
      ComplaintModel complaint, int rating) {
    return InkWell(
      onTap: () {
        ref.read(complaintstListProvider.notifier).updateComplaint(
              complaint.copyWith(evaluation: rating),
            );
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
    );
  }
}
