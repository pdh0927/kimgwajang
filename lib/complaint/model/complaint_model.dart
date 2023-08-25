class ComplaintModel {
  final String? id;
  final String title;
  final String content;
  final String reply;
  final String imagePath;
  final int? evaluation;

  ComplaintModel({
    this.id,
    required this.title,
    required this.content,
    required this.reply,
    required this.imagePath,
    this.evaluation,
  });

  ComplaintModel copyWith({
    String? id,
    String? title,
    String? content,
    String? reply,
    String? imagePath,
    int? evaluation,
  }) {
    return ComplaintModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      reply: reply ?? this.reply,
      imagePath: imagePath ?? this.imagePath,
      evaluation: evaluation ?? this.evaluation,
    );
  }

  @override
  String toString() {
    return 'ComplaintModel(id: $id, title: $title, content: $content, reply: $reply, imagePath: $imagePath, evaluation: $evaluation)';
  }
}
