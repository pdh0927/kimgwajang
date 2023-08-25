import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';
import 'package:kimgwajang/user/provider/user_proivder.dart';

class ComplaintCard extends ConsumerWidget {
  final ComplaintModel complaint;

  const ComplaintCard({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAdmin = ref.watch(userProvider)!.isAdmin;
    String statusLabel = complaint.reply.isEmpty
        ? '처리중'
        : (isAdmin
            ? (complaint.evaluation != null)
                ? '평가 완료'
                : '평가중'
            : '처리 완료');
    Color labelColor = (statusLabel == '처리중' && isAdmin)
        ? Colors.grey
        : (statusLabel == '평가 완료' || statusLabel == '처리 완료')
            ? Colors.green
            : Colors.orange;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
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
            Expanded(
                child: Text(complaint.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold))),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('내용:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                Text(complaint.content,
                    style: const TextStyle(color: Colors.black54)),
                if (complaint.imagePath != '')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(complaint.imagePath),
                        width: 125,
                        height: 125,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                const Text('답변:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text(complaint.reply,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black54)),
                if (complaint.reply.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: (complaint.evaluation != null)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: _buildStars(complaint.evaluation),
                            )
                          : (!isAdmin
                              ? ElevatedButton(
                                  onPressed: () {
                                    _showRatingOptions(context, complaint, ref);
                                  },
                                  child: const Text('답변 평가하기'),
                                )
                              : SizedBox.shrink()))
              ],
            ),
          ),
        ],
      ),
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
        ref.read(uncompletedComplaintstListProvider.notifier).updateComplaint(
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
