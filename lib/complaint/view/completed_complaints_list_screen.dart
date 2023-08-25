import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/component/complaints_list.dart';
import 'package:kimgwajang/complaint/model/complaint_model.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';
import 'package:kimgwajang/inference/models/category_type.dart';

class CompletedComplaintsListScreen extends ConsumerStatefulWidget {
  const CompletedComplaintsListScreen({super.key});

  @override
  ConsumerState<CompletedComplaintsListScreen> createState() =>
      _CompletedComplaintsListScreenState();
}

class _CompletedComplaintsListScreenState
    extends ConsumerState<CompletedComplaintsListScreen> {
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
        ref.watch(completedComplaintstListProvider);
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
          '처리된 민원 목록',
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

class CategorySelector extends StatefulWidget {
  final Function(CategoryType) onCategorySelect;
  final List<ComplaintModel> complaints;

  const CategorySelector(
      {super.key, required this.complaints, required this.onCategorySelect});

  @override
  State createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  CategoryType? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<CategoryType>(
      value: _selectedCategory,
      hint: const Text('카테고리 선택'),
      items: CategoryType.values.map((CategoryType category) {
        return DropdownMenuItem<CategoryType>(
          value: category,
          child: Text(CategoryType.asString(category)),
        );
      }).toList(),
      onChanged: (CategoryType? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
        widget.onCategorySelect(newValue!);
      },
    );
  }
}
