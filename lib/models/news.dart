class News {
  const News(
      {required this.id,
      required this.title,
      required this.category,
      required this.validityDate,
      required this.imageUrl,
      required this.content});

  final String id;
  final String title;
  final String category;
  final String content;
  final DateTime validityDate;
  final String imageUrl;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'category': category,
      'date': validityDate,
      'imageUrl': imageUrl,
    };
  }

  static News fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      content: map['content'],
      validityDate: DateTime.parse(map['date']),
      imageUrl: map['imageUrl'],
    );
  }
}
