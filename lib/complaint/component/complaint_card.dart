import 'dart:io';

import 'package:flutter/material.dart';
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
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAdmin = ref.watch(userProvider)!.isAdmin;
    String statusLabel = complaint.reply == null
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
                Row(
                  children: [
                    const Text('답변:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(
                      width: 10,
                    ),
                    (complaint.reply == null && isAdmin)
                        ? ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    content: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 12),
                                        Text("AI가 답변을 생성 중입니다"),
                                        Image(
                                          image: AssetImage(
                                              'asset/image/logo.png'),
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
                                Navigator.of(context).pop();

                                _showAnswer(context, complaint, ref, aiAnswer!);
                              }).catchError((error) {
                                // 에러 발생 시 다이얼로그 닫기
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text('답변 하기'),
                          )
                        : const SizedBox(height: 0, width: 0)
                  ],
                ),
                const SizedBox(height: 5),
                Text(complaint.reply ?? '',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black54)),
                if (complaint.reply != null)
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
                              : const SizedBox(height: 0, width: 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAnswer(BuildContext context, Complaint complaint, WidgetRef ref,
      String aiAnswer) {
    final TextEditingController _answerController =
        TextEditingController(text: aiAnswer);
    bool useAI = true; // 인공지능으로 답변하기가 기본값으로 설정되었습니다.

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(10.0), // 주변의 여백 조정
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('민원 제목: ${complaint.title}'),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _answerController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '답변 입력',
                        ),
                        maxLines: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(useAI ? "인공지능 답변" : "직접 답변"),
                          Switch(
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
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // 버튼을 오른쪽으로 정렬
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                Complaint newComplaint = complaint.copyWith(
                                    reply: _answerController.text);

                                final dao =
                                    ComplaintsDao(PersistanceDb.getInstance());
                                await dao.updateComplaint(newComplaint);
                                Navigator.pop(context);
                              },
                              child: const Text("제출")),
                          const SizedBox(width: 8.0), // 버튼 사이에 간격 추가
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("취소")),
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
      BuildContext context, Complaint complaint, WidgetRef ref) {
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
      Complaint complaint, int rating) {
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
