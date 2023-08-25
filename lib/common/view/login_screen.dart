import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/accounts/model/account_role.dart';
import 'package:kimgwajang/accounts/service/user_service.dart';
import 'package:kimgwajang/common/view/root_tab.dart';
import 'package:kimgwajang/user/model/user_model.dart';
import 'package:kimgwajang/accounts/provider/user_proivder.dart';

const users = {
  'admin@gmail.com': '1234',
  'user@gmail.com': '1234',
};

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2);

  Future<String?> _authUser(LoginData data, WidgetRef ref) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    var userService = UserService();

    // power: power123
    // user: power123
    userService.authenticate(data.name, data.password).then((user) {
      // Success
      print(user);
      if (userService.getUserRole(user) == AccountRole.USER) {
        ref.read(userProvider.notifier).loadUser(
            UserModel(id: user.id, isAdmin: false, name: user.username));
      } else {
        ref.read(userProvider.notifier).loadUser(
            UserModel(id: user.id, isAdmin: true, name: user.username));
      }
      return Future.delayed(loginTime);
    }).catchError((err) {
      return 'User not exists';
    });
    return null;
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterLogin(
      theme: LoginTheme(
        logoWidth: 1,
      ),
      logo: const AssetImage('asset/image/logo.png'),
      userType:
          LoginUserType.name, // Change this to use name hint instead of email
      userValidator: (value) {
        if (value == null || value.isEmpty) {
          return 'ID cannot be empty!';
        }
        return null;
      },
      onLogin: (data) => _authUser(data, ref),
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const RootTab(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
