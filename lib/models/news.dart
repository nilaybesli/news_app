class News {
  const News(
      {required this.id,
      required this.title,
      required this.category,
      required this.imageUrl,
      required this.content});

  final String id;
  final String title;
  final String category;
  final String content;
  final String imageUrl;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'category': category,
      'imageUrl': imageUrl,
    };
  }

  static News fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['imageURL'] ?? '',
    );
  }
}
