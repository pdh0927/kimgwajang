import 'dart:async';

import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';

class ComplaintService {
  final ComplaintsDao complaintsDao =
      ComplaintsDao(PersistanceDb.getInstance());

  Future<Complaint> get(String id) async {
    return complaintsDao.findById(id);
  }

  Future<int> insert(Complaint complaint) async {
    return complaintsDao.persistComplaint(complaint);
  }

  Future<bool> update(Complaint complaint) async {
    return complaintsDao.updateComplaint(complaint);
  }

  Future delete(String id) async {
    return complaintsDao.deleteById(id);
  }
}
