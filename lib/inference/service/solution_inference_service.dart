import 'dart:async';

import 'package:kimgwajang/inference/models/solution_inference_request.dart';
import 'package:kimgwajang/inference/models/solution_inference_result.dart';
import 'package:kimgwajang/inference/service/chatgpt_inference_engine.dart';
import 'package:kimgwajang/inference/service/inference_service.dart';

class SolutionInferenceService
    implements
        InferenceService<SolutionInferenceRequest, SolvingInferenceResult> {
  final ChatGptInferenceEngine inferenceEngine = ChatGptInferenceEngine();

  @override
  Future<SolvingInferenceResult> inference(SolutionInferenceRequest request) {
    var completer = Completer<SolvingInferenceResult>();

    String payload = _serialize(request);
    inferenceEngine.inference(payload).then((value) {
      SolvingInferenceResult inferenceResult = SolvingInferenceResult(solution: value);
      completer.complete(inferenceResult);
    });

    return completer.future;
  }

  String _serialize(SolutionInferenceRequest request) {

    String contents =
        "너는 한 기관의 민원 담당이라고 생각하고, 너는 민원 담당 AI이며 이름은 '김과장'이야. "
        "내가 민원에 대한 내용을 작성할거야.\n"
        "너가 생각하는 민원에 대한 해결책을 짧게 알려줘 "
        "\t제목 : ${request.title}\n\t내용 : ${request.content}";

    return contents;
  }
}