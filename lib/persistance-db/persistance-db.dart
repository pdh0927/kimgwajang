import 'dart:io';

import 'package:kimgwajang/accounts/model/accounts.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'persistance-db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [Accounts], daos: [AccountsDao])
class PersistanceDb extends _$PersistanceDb {
  static PersistanceDb? _instance;

  static void init() {
    _instance ??= PersistanceDb(_openConnection());
  }

  static PersistanceDb getInstance() {
    init();
    return _instance!;
  }

  PersistanceDb(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
