class Note {
  final String id;
  final String title;
  final String content;
  final DateTime creationDate;
  final int colorId;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.creationDate,
    required this.colorId,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      colorId: json['colorId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'creationDate': creationDate.toIso8601String(),
      'colorId': colorId,
    };
  }
}
