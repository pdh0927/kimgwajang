import 'package:kimgwajang/inference/models/inference_model.dart';

class CategoryInferenceRequest implements InferenceModel {
  final String title;
  final String content;

  CategoryInferenceRequest({required this.title, required this.content});
}
