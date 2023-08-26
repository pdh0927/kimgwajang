import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/accounts/provider/user_provider.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';
import 'package:kimgwajang/inference/models/solution_inference_request.dart';
import 'package:kimgwajang/inference/service/solution_inference_service.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';

class ComplaintCard extends ConsumerWidget {
  final Complaint complaint;

  const ComplaintCard({
    super.key,
    required this.complaint,
  });

  @override
  material.Widget build(material.BuildContext context, WidgetRef ref) {
    bool isAdmin = ref.watch(userProvider)!.isAdmin;
    String statusLabel = complaint.reply == null
        ? '처리중'
        : (isAdmin
            ? (complaint.evaluation != null)
                ? '평가 완료'
                : '평가중'
            : '처리 완료');
    material.Color labelColor = (statusLabel == '처리중' && isAdmin)
        ? material.Colors.grey
        : (statusLabel == '평가 완료' || statusLabel == '처리 완료')
            ? material.Colors.green
            : material.Colors.orange;

    return material.Card(
      elevation: 4,
      shape: material.RoundedRectangleBorder(
        borderRadius: material.BorderRadius.circular(10),
      ),
      child: material.ExpansionTile(
        title: material.Row(
          children: [
            material.Container(
              width: 80,
              alignment: material.Alignment.center,
              padding: const material.EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: material.BoxDecoration(
                color: labelColor,
                borderRadius: material.BorderRadius.circular(15),
              ),
              child: material.Text(statusLabel,
                  style: const material.TextStyle(
                      color: material.Colors.white,
                      fontWeight: material.FontWeight.bold)),
            ),
            const material.SizedBox(width: 8),
            material.Expanded(
                child: material.Text(complaint.title,
                    style: const material.TextStyle(
                        fontSize: 16, fontWeight: material.FontWeight.bold))),
          ],
        ),
        children: [
          material.Padding(
            padding: const material.EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: material.Column(
              crossAxisAlignment: material.CrossAxisAlignment.start,
              children: [
                const material.Text('내용:',
                    style: material.TextStyle(
                        fontWeight: material.FontWeight.bold, fontSize: 14)),
                const material.SizedBox(height: 5),
                material.Text(complaint.content,
                    style: const material.TextStyle(
                        color: material.Colors.black54)),
                if (complaint.imagePath != '')
                  material.Padding(
                    padding:
                        const material.EdgeInsets.symmetric(vertical: 10.0),
                    child: material.ClipRRect(
                      borderRadius: material.BorderRadius.circular(10),
                      child: material.Image.file(
                        File(complaint.imagePath),
                        width: 125,
                        height: 125,
                        fit: material.BoxFit.cover,
                      ),
                    ),
                  ),
                const material.SizedBox(height: 10),
                material.Row(
                  children: [
                    const material.Text('답변:',
                        style: material.TextStyle(
                            fontWeight: material.FontWeight.bold,
                            fontSize: 16)),
                    const material.SizedBox(
                      width: 10,
                    ),
                    (complaint.reply == null && isAdmin)
                        ? material.ElevatedButton(
                            onPressed: () {
                              material.showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (material.BuildContext context) {
                                  return const material.AlertDialog(
                                    content: material.Row(
                                      mainAxisSize: material.MainAxisSize.min,
                                      children: [
                                        material.SizedBox(
                                            height: 13,
                                            width: 13,
                                            child: material
                                                .CircularProgressIndicator()),
                                        material.SizedBox(width: 12),
                                        material.Text("AI가 답변을 생성 중입니다"),
                                        material.Image(
                                          image: material.AssetImage(
                                              'asset/image/logo_no_word.png'),
                                          height: 50,
                                          width: 50,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );

                              String? aiAnswer;
                              var solvingService = SolutionInferenceService();
                              solvingService
                                  .inference(SolutionInferenceRequest(
                                      title: "민원", content: complaint.content))
                                  .then((value) {
                                aiAnswer = value.getSolution();

                                // 다이얼로그 닫기
                                material.Navigator.of(context).pop();

                                _showAnswer(context, complaint, ref, aiAnswer!);
                              }).catchError((error) {
                                // 에러 발생 시 다이얼로그 닫기
                                material.Navigator.of(context).pop();
                              });
                            },
                            child: const material.Text('답변 하기'),
                          )
                        : const material.SizedBox(height: 0, width: 0)
                  ],
                ),
                const material.SizedBox(height: 5),
                material.Text(complaint.reply ?? '',
                    style: const material.TextStyle(
                        fontSize: 16, color: material.Colors.black54)),
                if (complaint.reply != null)
                  material.Padding(
                      padding:
                          const material.EdgeInsets.symmetric(vertical: 10.0),
                      child: (complaint.evaluation != null)
                          ? material.Row(
                              crossAxisAlignment:
                                  material.CrossAxisAlignment.center,
                              children: _buildStars(complaint.evaluation),
                            )
                          : (!isAdmin
                              ? material.ElevatedButton(
                                  onPressed: () {
                                    _showRatingOptions(context, complaint, ref);
                                  },
                                  child: const material.Text('답변 평가하기'),
                                )
                              : const material.SizedBox(height: 0, width: 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAnswer(material.BuildContext context, Complaint complaint,
      WidgetRef ref, String aiAnswer) {
    final material.TextEditingController _answerController =
        material.TextEditingController(text: aiAnswer);
    bool useAI = true; // 인공지능으로 답변하기가 기본값으로 설정되었습니다.

    material.showDialog(
      context: context,
      builder: (context) {
        return material.StatefulBuilder(
          builder: (context, setState) {
            return material.Dialog(
              insetPadding: const material.EdgeInsets.all(10.0), // 주변의 여백 조정
              child: material.SingleChildScrollView(
                child: material.Padding(
                  padding: const material.EdgeInsets.all(16.0),
                  child: material.Column(
                    mainAxisSize: material.MainAxisSize.min,
                    children: [
                      material.Text('민원 제목: ${complaint.title}'),
                      const material.SizedBox(height: 16.0),
                      material.TextField(
                        controller: _answerController,
                        decoration: const material.InputDecoration(
                          border: material.OutlineInputBorder(),
                          labelText: '답변 입력',
                        ),
                        maxLines: 20,
                      ),
                      material.Row(
                        mainAxisAlignment:
                            material.MainAxisAlignment.spaceBetween,
                        children: [
                          material.Text(useAI ? "인공지능 답변" : "직접 답변"),
                          material.Switch(
                            value: useAI,
                            onChanged: (value) {
                              setState(() {
                                useAI = value;
                                _answerController.text = value ? aiAnswer : '';
                              });
                            },
                          ),
                        ],
                      ),
                      material.Row(
                        mainAxisAlignment:
                            material.MainAxisAlignment.end, // 버튼을 오른쪽으로 정렬
                        children: [
                          material.ElevatedButton(
                              onPressed: () async {
                                Complaint newComplaint = complaint.copyWith(
                                    reply: Value.ofNullable(
                                        _answerController.text));
                                ref
                                    .read(completedComplaintstListProvider
                                        .notifier)
                                    .addComplaint(newComplaint);
                                ref
                                    .read(uncompletedComplaintstListProvider
                                        .notifier)
                                    .deleteComplaint(complaint);

                                final dao =
                                    ComplaintsDao(PersistanceDb.getInstance());
                                await dao.updateComplaint(complaint.copyWith(
                                    reply: Value.ofNullable(
                                        _answerController.text)));
                                material.Navigator.pop(context);
                              },
                              child: const material.Text("제출")),
                          const material.SizedBox(width: 8.0), // 버튼 사이에 간격 추가
                          material.ElevatedButton(
                              onPressed: () {
                                material.Navigator.pop(context);
                              },
                              child: const material.Text("취소")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<material.Widget> _buildStars(int? evaluation) {
    List<material.Widget> stars = [const material.Text('답변 만족도 : ')];
    for (var i = 0; i < 5; i++) {
      stars.add(material.Icon(
        i < (evaluation ?? 0)
            ? material.Icons.star
            : material.Icons.star_border,
        color: material.Colors.yellow,
      ));
    }
    return stars;
  }

  void _showRatingOptions(
      material.BuildContext context, Complaint complaint, WidgetRef ref) {
    material.showDialog(
      context: context,
      builder: (material.BuildContext context) {
        return material.AlertDialog(
          title: const material.Text('답변 평가하기'),
          titlePadding: const material.EdgeInsets.all(20),
          contentPadding:
              const material.EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          content: material.SizedBox(
            height: 336,
            child: material.Column(
              mainAxisSize: material.MainAxisSize.min,
              children: [
                _buildRatingOption(context, ref, '매우 만족',
                    material.Icons.sentiment_very_satisfied, complaint, 5),
                _divider(),
                _buildRatingOption(context, ref, '대체로 만족',
                    material.Icons.sentiment_satisfied, complaint, 4),
                _divider(),
                _buildRatingOption(context, ref, '보통',
                    material.Icons.sentiment_neutral, complaint, 3),
                _divider(),
                _buildRatingOption(context, ref, '대체로 불만족',
                    material.Icons.sentiment_dissatisfied, complaint, 2),
                _divider(),
                _buildRatingOption(context, ref, '불만족',
                    material.Icons.sentiment_very_dissatisfied, complaint, 1),
                _divider(),
                _buildRatingOption(context, ref, '매우 불만족',
                    material.Icons.mood_bad, complaint, 0),
              ],
            ),
          ),
          actions: <material.Widget>[
            material.TextButton(
              style: material.ButtonStyle(
                padding:
                    material.MaterialStateProperty.all<material.EdgeInsets>(
                        const material.EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20)),
              ),
              child: const material.Text('취소'),
              onPressed: () {
                material.Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  material.Widget _divider() => const material.Divider(thickness: 1, height: 0);

  material.Widget _buildRatingOption(
      material.BuildContext context,
      WidgetRef ref,
      String title,
      material.IconData icon,
      Complaint complaint,
      int rating) {
    return material.InkWell(
      onTap: () {
        ref.read(completedComplaintstListProvider.notifier).updateComplaint(
              complaint.copyWith(evaluation: Value.ofNullable(rating)),
            );
        material.Navigator.pop(context);
      },
      child: material.ListTile(
        leading:
            material.Icon(icon, color: material.Theme.of(context).primaryColor),
        title: material.Text(title),
      ),
    );
  }
}
