import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';

final uncompletedComplaintstListProvider =
    StateNotifierProvider<UncomPletedComplaintsListNotifier, List<Complaint>>(
        (ref) {
  return UncomPletedComplaintsListNotifier();
});

class UncomPletedComplaintsListNotifier extends StateNotifier<List<Complaint>> {
  UncomPletedComplaintsListNotifier() : super([]) {
    fetchUncompletedComplaintsData();
  }
  final dao = ComplaintsDao(PersistanceDb.getInstance());

  void fetchUncompletedComplaintsData() async {
    List<Complaint> uncompletedComplaints = await dao.findAllNotReplied();
    state = uncompletedComplaints;
  }

  void addComplaint(Complaint complaintModel) async {
    await dao.persistComplaint(complaintModel);
    state = [...state, complaintModel];
  }

  void updateComplaint(Complaint updatedComplaint) async {
    List<Complaint> updatedState = state.map((complaint) {
      if (complaint.title == updatedComplaint.title &&
          complaint.content == updatedComplaint.content) {
        return updatedComplaint;
      }
      return complaint;
    }).toList();

    state = updatedState;
    await dao.updateComplaint(updatedComplaint);
  }

  void deleteComplaint(Complaint complaintModel) {
    state.remove(complaintModel);
    state = [...state];
  }
}

final completedComplaintstListProvider =
    StateNotifierProvider<ComPletedComplaintsListNotifier, List<Complaint>>(
        (ref) {
  return ComPletedComplaintsListNotifier();
});

class ComPletedComplaintsListNotifier extends StateNotifier<List<Complaint>> {
  ComPletedComplaintsListNotifier() : super([]) {
    fetchCompletedComplaintsData();
  }
  final dao = ComplaintsDao(PersistanceDb.getInstance());

  void fetchCompletedComplaintsData() async {
    List<Complaint> completedComplaints = await dao.findAllReplied();

    state = completedComplaints;
  }

  void addComplaint(Complaint complaintModel) async {
    state = [...state, complaintModel];
  }

  void updateComplaint(Complaint updatedComplaint) async {
    List<Complaint> updatedState = state.map((complaint) {
      if (complaint.title == updatedComplaint.title &&
          complaint.content == updatedComplaint.content) {
        return updatedComplaint;
      }
      return complaint;
    }).toList();

    state = updatedState;
    await dao.updateComplaint(updatedComplaint);
  }
}
