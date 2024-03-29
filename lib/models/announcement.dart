class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.validityDate,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final DateTime validityDate;
  final String imageUrl;
}
