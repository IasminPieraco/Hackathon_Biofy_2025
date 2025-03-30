class CategoryModel {
  final String category;
  final double percentual;

  CategoryModel({
    required this.category,
    required this.percentual,
  });

  // Converte um JSON para um objeto CategoryModel
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      category: json['category'] as String,
      percentual: (json['percentual'] as num).toDouble(),
    );
  }

  // Converte um objeto CategoryModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'percentual': percentual,
    };
  }
}
