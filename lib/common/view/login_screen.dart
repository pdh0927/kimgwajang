import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/common/view/root_tab.dart';
import 'package:kimgwajang/user/model/user_model.dart';
import 'package:kimgwajang/user/provider/user_proivder.dart';

const users = {
  'admin@gmail.com': '1234',
  'user@gmail.com': '1234',
};

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
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
      title: '김과장',
      logo: const AssetImage('asset/image/logo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        ref
            .read(userProvider.notifier)
            .loadUser(UserModel(id: 'tmp', isAdmin: true, name: 'admin'));
        // ref
        //     .read(userProvider.notifier)
        //     .loadUser(UserModel(id: 'tmp', isAdmin: true, name: 'user'));

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const RootTab(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
