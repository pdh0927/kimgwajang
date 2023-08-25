import 'dart:developer';

import 'package:kimgwajang/accounts/model/account_role.dart';
import 'package:kimgwajang/accounts/service/user_service.dart';
import 'package:kimgwajang/inference/models/category_inference_request.dart';
import 'package:kimgwajang/inference/models/category_inference_result.dart';
import 'package:kimgwajang/inference/models/solution_inference_request.dart';
import 'package:kimgwajang/inference/service/categorize_inference_service.dart';
import 'package:kimgwajang/inference/service/solution_inference_service.dart';

void testStart() {
  var userService = UserService();
  userService.authenticate('power', 'power123').then((user) {
    // Success

    if (userService.getUserRole(user) == AccountRole.USER) {
      // User
    } else {
      // Admin
    }
  }).catchError((err) {
    // Error
  });

  var service = CategorizeInferenceService();
  service
      .inference(CategoryInferenceRequest(
          title: "민원", content: "대구 시청 앞, 차가 너무 막혀요 해결해주세요!"))
      .then((response) {
    CategoryInferenceResult result = response;

    log(result.getCategoryType().toString());
  });

  var solvingService = SolutionInferenceService();
  solvingService
      .inference(SolutionInferenceRequest(
          title: "민원", content: "대구 시청 앞, 차가 너무 막혀요 해결해주세요!"))
      .then((value) {
    log(value.getSolution());
  });
}
