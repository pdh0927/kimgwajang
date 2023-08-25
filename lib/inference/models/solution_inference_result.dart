
import 'package:kimgwajang/inference/models/inference_result.dart';

class SolvingInferenceResult implements InferenceResult {
  final String solution;

  SolvingInferenceResult({required this.solution});

  String getSolution() {
    return solution;
  }  
}