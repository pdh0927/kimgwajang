import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/const/data.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';

final complaintstListProvider =
    StateNotifierProvider<ComplaintsListNotifier, List<ComplaintModel>>((ref) {
  return ComplaintsListNotifier();
});

class ComplaintsListNotifier extends StateNotifier<List<ComplaintModel>> {
  ComplaintsListNotifier() : super([]) {
    fetchComplaintsData(complaints);
  }

  void fetchComplaintsData(List<ComplaintModel> complaints) {
    state = complaints;
  }

  void addComplaint(ComplaintModel complaintModel) {
    state = [...state, complaintModel];
  }
}
