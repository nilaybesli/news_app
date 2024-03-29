class News {
  const News(
      {required this.id,
      required this.title,
      required this.category,
      required this.validityDate,
      required this.imageUrl});

  final String id;
  final String title;
  final String category;
  final DateTime validityDate;
  final String imageUrl;
}
