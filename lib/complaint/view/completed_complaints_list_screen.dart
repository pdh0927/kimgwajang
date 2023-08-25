import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimgwajang/complaint/component/complaints_list.dart';
import 'package:kimgwajang/complaint/provider/complaints_list_provider.dart';
import 'package:kimgwajang/inference/models/category_type.dart';
import 'package:kimgwajang/persistance-db/persistance-db.dart';

class CompletedComplaintsListScreen extends ConsumerStatefulWidget {
  const CompletedComplaintsListScreen({super.key});

  @override
  ConsumerState<CompletedComplaintsListScreen> createState() =>
      _CompletedComplaintsListScreenState();
}

class _CompletedComplaintsListScreenState
    extends ConsumerState<CompletedComplaintsListScreen> {
  CategoryType? selectedCategory;
  List<Complaint> filteredComplaints = [];

  void onCategorySelect(CategoryType? categoryType) {
    setState(() {
      selectedCategory = categoryType;
    });
  }

  @override
  void initState() {
    ref
        .read(completedComplaintstListProvider.notifier)
        .fetchCompletedComplaintsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Complaint> complaints = ref.watch(completedComplaintstListProvider);
    if (selectedCategory != null) {
      filteredComplaints = complaints
          .where((complaint) => complaint.category == selectedCategory!.value)
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
              padding: const EdgeInsets.only(top: 8, left: 8.0, right: 8.0),
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

// class CategorySelector extends StatefulWidget {
//   final Function(CategoryType) onCategorySelect;
//   final List<Complaint> complaints;

//   const CategorySelector(
//       {super.key, required this.complaints, required this.onCategorySelect});

//   @override
//   State createState() => _CategorySelectorState();
// }

// class _CategorySelectorState extends State<CategorySelector> {
//   CategoryType? _selectedCategory;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<CategoryType>(
//       value: _selectedCategory,
//       hint: const Text('카테고리 선택'),
//       items: CategoryType.values.map((CategoryType category) {
//         return DropdownMenuItem<CategoryType>(
//           value: category,
//           child: Text(CategoryType.asString(category)),
//         );
//       }).toList(),
//       onChanged: (CategoryType? newValue) {
//         setState(() {
//           _selectedCategory = newValue;
//         });
//         widget.onCategorySelect(newValue!);
//       },
//     );
//   }
// }
class CategorySelector extends StatefulWidget {
  final Function(CategoryType?) onCategorySelect;
  final List<Complaint> complaints;

  const CategorySelector({
    super.key,
    required this.complaints,
    required this.onCategorySelect,
  });

  @override
  State createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  CategoryType? _selectedCategory;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedCategory == null
                      ? '카테고리 선택'
                      : CategoryType.asString(_selectedCategory!),
                ),
                Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
            ),
            itemCount: CategoryType.values.length + 1,
            itemBuilder: (context, index) {
              CategoryType? category;
              if (index != 0) {
                category = CategoryType.values[index - 1];
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                    _isExpanded = false;
                  });

                  widget.onCategorySelect(index == 0 ? null : category);
                },
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedCategory == category
                          ? Colors.blue
                          : Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    index == 0 ? '전체' : CategoryType.asString(category!),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
