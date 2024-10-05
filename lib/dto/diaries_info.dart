class DiaryInfo {
  final String id;
  final String images;
  final String comments;
  final String publicRange;
  final String category;
  final String userId;
  final int grade;
  final bool recommend;

  DiaryInfo({
    required this.id,
    required this.images,
    required this.comments,
    required this.publicRange,
    required this.category,
    required this.userId,
    required this.grade,
    required this.recommend,
  });

  factory DiaryInfo.fromJson(Map<String, dynamic> json) {
    return DiaryInfo(
      id: json['id'],
      images: json['images'],
      comments: json['comments'],
      publicRange: json['publicRange'],
      category: json['category'],
      userId: json['userId'],
      grade: json['grade'],
      recommend: json['recommend'],
    );
  }

  // You can also add methods for JSON serialization/deserialization if needed
}