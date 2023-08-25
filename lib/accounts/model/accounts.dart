import 'package:kimgwajang/accounts/model/account_role.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';
import 'package:moor/moor.dart';

part 'accounts.g.dart';

class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get password => text()();
  TextColumn get role => text()();

  @override
  List<String> get customConstraints => ['UNIQUE (username)'];
}

@UseDao(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<PersistanceDb>
    with _$AccountsDaoMixin {
  AccountsDao(PersistanceDb db) : super(db);

  Future<Account> findById(String id) async {
    return (select(accounts)..where((t) => t.id.equals(id))).getSingle();
  }

  createOne() async {
    final account = Account(
        id: '63a6fc05-8263-4e70-93de-f5db58f5634f',
        username: 'admin',
        password:
            "\$2a\$12\$azO3Oq1OuZqCpDYR74vRAekmE9vUWmXDYkgYJlpUxj6Ff8j13uq0.",
        role: 'ADMIN');
    into(accounts).insert(account);
  }

  Future<List<Account>> findAll() async {
    return (select(accounts)).get();
  }

  Future<Account> findByUsername(String username) async {
    return (select(accounts)..where((t) => t.username.equals(username)))
        .getSingle();
  }

  Future<int> deleteAll() async {
    return delete(accounts).go();
  }
}
