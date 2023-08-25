import 'package:kimgwajang/inference/models/inference_model.dart';
import 'package:kimgwajang/inference/models/inference_result.dart';

abstract class InferenceService<M extends InferenceModel,
    R extends InferenceResult> {
  Future<R> inference(M model);
}
