class PhotoModel {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoModel({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      url: json["url"] ?? "",
      thumbnailUrl: json["thumbnailUrl"] ?? "",
    );
  }
}
