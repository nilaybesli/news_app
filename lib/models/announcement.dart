class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.content,
  });

  final String id;
  final String title;
  final String content;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }

  static Announcement fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
    );
  }
}
