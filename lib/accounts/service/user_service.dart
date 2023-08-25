import 'dart:async';
import 'dart:developer';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:kimgwajang/accounts/model/account_role.dart';
import 'package:kimgwajang/accounts/model/accounts.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';

class UserService {
  final AccountsDao accountsDao = AccountsDao(PersistanceDb.getInstance());

  Future<Account> authenticate(String username, String password) async {
    var completer = Completer<Account>();

    accountsDao.findByUsername(username).then((value) {
      bool isCorrect = DBCrypt().checkpw(password, value.password);

      if (isCorrect) {
        completer.complete(value);
        return;
      }
      completer.completeError("Unable to authenticate, Please check account");
    }).catchError((err) {
      log(err.message);
      completer.completeError("Unable to authenticate, Please check account");
    });

    return completer.future;
  }

  AccountRole getUserRole(Account account) {
    String role = account.role;
    return AccountRole.fromString(role);
  }
}
