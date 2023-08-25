
import 'package:kimgwajang/inference/models/inference_model.dart';

class SolutionInferenceRequest implements InferenceModel {
  final String title;
  final String content;

  SolutionInferenceRequest({required this.title, required this.content});
}
