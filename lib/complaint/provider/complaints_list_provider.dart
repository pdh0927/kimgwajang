import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/const/data.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';

final uncompletedComplaintstListProvider = StateNotifierProvider<
    UncomPletedComplaintsListNotifier, List<ComplaintModel>>((ref) {
  return UncomPletedComplaintsListNotifier();
});

class UncomPletedComplaintsListNotifier
    extends StateNotifier<List<ComplaintModel>> {
  UncomPletedComplaintsListNotifier() : super([]) {
    fetchUncompletedComplaintsData();
  }

  void fetchUncompletedComplaintsData() {
    // reply != ''인 complaints 불러오기

    state = uncompletedComplaints;
  }

  void addComplaint(ComplaintModel complaintModel) {
    state = [...state, complaintModel];
  }

  void updateComplaint(ComplaintModel updatedComplaint) {
    List<ComplaintModel> updatedState = state.map((complaint) {
      if (complaint.title == updatedComplaint.title &&
          complaint.content == updatedComplaint.content) {
        return updatedComplaint;
      }
      return complaint;
    }).toList();

    state = updatedState;
  }

  void deleteComplaint(ComplaintModel complaintModel) {
    state.remove(complaintModel);
    state = [...state];
  }
}

final completedComplaintstListProvider = StateNotifierProvider<
    ComPletedComplaintsListNotifier, List<ComplaintModel>>((ref) {
  return ComPletedComplaintsListNotifier();
});

class ComPletedComplaintsListNotifier
    extends StateNotifier<List<ComplaintModel>> {
  ComPletedComplaintsListNotifier() : super([]) {
    fetchCompletedComplaintsData();
  }

  void fetchCompletedComplaintsData() {
    // reply != ''인 complaints 불러오기

    state = completedComplaints;
  }

  void addComplaint(ComplaintModel complaintModel) {
    state = [...state, complaintModel];
  }

  void updateComplaint(ComplaintModel updatedComplaint) {
    List<ComplaintModel> updatedState = state.map((complaint) {
      if (complaint.title == updatedComplaint.title &&
          complaint.content == updatedComplaint.content) {
        return updatedComplaint;
      }
      return complaint;
    }).toList();

    state = updatedState;
  }
}
