import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/component/complaints_list.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';
import 'package:kimgwajang/complaint/view/completed_complaints_list_screen.dart';
import 'package:kimgwajang/inference/models/category_type.dart';

class UncompletedComplaintsListScreen extends ConsumerStatefulWidget {
  const UncompletedComplaintsListScreen({super.key});

  @override
  ConsumerState<UncompletedComplaintsListScreen> createState() =>
      _UncompletedComplaintsListScreenState();
}

class _UncompletedComplaintsListScreenState
    extends ConsumerState<UncompletedComplaintsListScreen> {
  CategoryType? selectedCategory;
  List<ComplaintModel> filteredComplaints = [];

  void onCategorySelect(CategoryType categoryType) {
    setState(() {
      selectedCategory = categoryType;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ComplaintModel> complaints =
        ref.watch(uncompletedComplaintstListProvider);
    if (selectedCategory != null) {
      filteredComplaints = complaints
          .where((complaint) => complaint.categoryType == selectedCategory)
          .toList();
    } else {
      filteredComplaints = complaints;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '미처리된 민원 목록',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 8.0),
              child: CategorySelector(
                  complaints: complaints, onCategorySelect: onCategorySelect),
            ),
          ),
          Expanded(child: ComplaintsList(complaints: filteredComplaints)),
        ],
      ),
    );
  }
}
