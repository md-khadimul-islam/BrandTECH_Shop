import 'package:hive/hive.dart';

import '../../domain/entities/product_entity.dart';

class RatingModel extends HiveObject {
  @HiveField(0)
  final double rate;

  @HiveField(1)
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(rate: (json['rate'] as num).toDouble(), count: json['count'] as int);

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};

  RatingEntity toEntity() => RatingEntity(rate: rate, count: count);
}

class ProductModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final RatingModel rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int,
        title: json['title'] as String,
        price: (json['price'] as num).toDouble(),
        description: json['description'] as String,
        category: json['category'] as String,
        image: json['image'] as String,
        rating: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
        id: entity.id,
        title: entity.title,
        price: entity.price,
        description: entity.description,
        category: entity.category,
        image: entity.image,
        rating: RatingModel(rate: entity.rating.rate, count: entity.rating.count),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating.toJson(),
      };

  ProductEntity toEntity() =>
      ProductEntity(id: id, title: title, price: price, description: description, category: category, image: image, rating: rating.toEntity());
}
