import 'package:kimgwajang/inference/models/category_type.dart';

class ComplaintModel {
  final String? id;
  final String title;
  final String content;
  final String reply;
  final String imagePath;
  final int? evaluation;
  final CategoryType categoryType;

  ComplaintModel({
    this.id,
    required this.title,
    required this.content,
    required this.reply,
    required this.imagePath,
    required this.categoryType,
    this.evaluation,
  });

  ComplaintModel copyWith({
    String? id,
    String? title,
    String? content,
    String? reply,
    String? imagePath,
    CategoryType? categoryType,
    int? evaluation,
  }) {
    return ComplaintModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      reply: reply ?? this.reply,
      imagePath: imagePath ?? this.imagePath,
      categoryType: categoryType ?? this.categoryType,
      evaluation: evaluation ?? this.evaluation,
    );
  }

  @override
  String toString() {
    return 'ComplaintModel(id: $id, title: $title, content: $content, reply: $reply, imagePath: $imagePath, categoryType: $categoryType, evaluation: $evaluation)';
  }
}
