import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kimgwajang/user/model/user_model.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  loadUser(UserModel userModel) {
    state = userModel;
  }
}
