import 'package:drift/drift.dart';
import 'package:kimgwajang/accounts/model/accounts.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';

import 'connection.dart' as impl;

part 'persistance-db.g.dart';

@DriftDatabase(tables: [Accounts, Complaints])
class PersistanceDb extends _$PersistanceDb {
  static PersistanceDb? _instance;

  static void init() {
    _instance ??= PersistanceDb(impl.connect());
  }

  static PersistanceDb getInstance() {
    init();
    return _instance!;
  }

  PersistanceDb(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
