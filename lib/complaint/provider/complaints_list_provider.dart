import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/const/data.dart';
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

  void fetchUncompletedComplaintsData() {
    // reply != ''인 complaints 불러오기

    state = uncompletedComplaints;
  }

  void addComplaint(Complaint complaintModel) {
    state = [...state, complaintModel];
  }

  void updateComplaint(Complaint updatedComplaint) {
    List<Complaint> updatedState = state.map((complaint) {
      if (complaint.title == updatedComplaint.title &&
          complaint.content == updatedComplaint.content) {
        return updatedComplaint;
      }
      return complaint;
    }).toList();

    state = updatedState;
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

  void fetchCompletedComplaintsData() {
    // reply != ''인 complaints 불러오기

    state = completedComplaints;
  }

  void addComplaint(Complaint complaintModel) {
    state = [...state, complaintModel];
  }

  void updateComplaint(Complaint updatedComplaint) {
    List<Complaint> updatedState = state.map((complaint) {
      if (complaint.title == updatedComplaint.title &&
          complaint.content == updatedComplaint.content) {
        return updatedComplaint;
      }
      return complaint;
    }).toList();

    state = updatedState;
  }
}
