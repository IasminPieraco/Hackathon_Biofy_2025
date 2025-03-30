class ImageModel {
  final String imageUrl;
  final String name;
  final String date;

  ImageModel({required this.imageUrl, required this.name, required this.date});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageUrl: json['image'],
      name: json['name'],
      date: json['date'],
    );
  }
}
