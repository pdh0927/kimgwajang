
import 'package:kimgwajang/inference/models/category_type.dart';
import 'package:kimgwajang/inference/models/inference_result.dart';

class CategoryInferenceResult implements InferenceResult {
  final CategoryType type;

  CategoryInferenceResult({required this.type});

  CategoryType getCategoryType() {
    return type;
  }  
}