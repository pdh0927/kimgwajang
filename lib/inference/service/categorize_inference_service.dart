import 'dart:async';

import 'package:kimgwajang/inference/models/category_inference_request.dart';
import 'package:kimgwajang/inference/models/category_inference_result.dart';
import 'package:kimgwajang/inference/models/category_type.dart';
import 'package:kimgwajang/inference/service/idly_inference_engine.dart';
import 'package:kimgwajang/inference/service/inference_service.dart';

class CategorizeInferenceService
    implements
        InferenceService<CategoryInferenceRequest, CategoryInferenceResult> {
  final IdlyGptInferenceEngine inferenceEngine = IdlyGptInferenceEngine();

  @override
  Future<CategoryInferenceResult> inference(
      CategoryInferenceRequest request) async {
    var completer = Completer<CategoryInferenceResult>();

    String payload = _serialize(request);
    inferenceEngine.inference(payload).then((value) {
      CategoryType categoryType = CategoryType.fromString(value);
      CategoryInferenceResult inferenceResult =
          CategoryInferenceResult(type: categoryType);
      completer.complete(inferenceResult);
    });

    return completer.future;
  }

  String _serialize(CategoryInferenceRequest request) {
    // serialize categories
    List<String> categoryTokens = [];
    for (var category in CategoryType.values) {
      categoryTokens.add(category.value);
    }

    String categories = categoryTokens.join(', ');
    String contents =
        "아래의 글을 토대로 민원을 작성할거야. 내가 주는 카테고리들 중에 가장 관련있는 거를 골라줘. 다른 응답 및 말 없이 카테고리 값만 답변해줘\n카테고리 : [$categories]\n"
        "\t제목 : ${request.title}\n\t내용 : ${request.content}";
    return contents;
  }
}
