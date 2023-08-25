import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/accounts/model/accounts.dart';
import 'package:kimgwajang/common/view/login_screen.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';
import 'package:moor/moor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  PersistanceDb.init();

  // AccountsDao의 인스턴스를 생성합니다.
  // final dao = AccountsDao(PersistanceDb.getInstance());

  // createOne 메서드를 호출합니다.
  // await dao.createOne();

  runApp(const ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
