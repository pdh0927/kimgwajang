import 'package:kimgwajang/persistance-db/persistance-db.dart';
import 'package:moor/moor.dart';

part 'complaint_model.g.dart';

class Complaints extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get reply => text().nullable()();
  TextColumn get imagePath => text()();
  IntColumn get evaluation => integer().nullable()();
  TextColumn get category => text()();
}

@UseDao(tables: [Complaints])
class ComplaintsDao extends DatabaseAccessor<PersistanceDb>
    with _$ComplaintsDaoMixin {
  ComplaintsDao(PersistanceDb db) : super(db);

  Future<Complaint> findById(String id) async {
    return (select(complaints)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<Complaint>> findAll() async {
    return (select(complaints)).get();
  }

  Future<List<Complaint>> findAllReplied() async {
    return (select(complaints)..where((t) => t.reply.isNotNull())).get();
  }

  Future<List<Complaint>> findAllNotReplied() async {
    return (select(complaints)..where((t) => t.reply.isNull())).get();
  }

  Future<int> persistComplaint(Complaint complaint) async {
    return into(complaints).insert(complaint);
  }

  Future<bool> updateComplaint(Complaint complaint) async {
    return (update(complaints).replace(complaint));
  }

  Future<int> deleteAll() async {
    return delete(complaints).go();
  }

  Future deleteById(String id) async {
    return (delete(complaints)
          ..where((t) {
            return t.id.equals(id);
          }))
        .go();
  }
}
