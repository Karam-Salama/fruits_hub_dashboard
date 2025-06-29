import 'dart:io';
import 'package:fruits_hub_dashboard/modules/add_product/data/models/review_model.dart';
import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String name;
  final String code;
  final String description;
  final num price;
  final num discount;
  final bool isFeatured;
  final String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final num avgRating;
  final num ratingCount;
  final int unitAmount;
  final int sellingCount;
  final List<ReviewModel> reviews;
  final File? image;

  ProductModel({
    required this.name,
    required this.code,
    required this.description,
    required this.price,
    required this.discount,
    required this.isFeatured,
    required this.expirationsMonths,
    required this.isOrganic,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.reviews,
    this.imageUrl,
    this.sellingCount = 0,
    this.avgRating = 0,
    this.ratingCount = 0,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
      price: json['price'] as num,
      discount: json['discount'] as num,
      isFeatured: json['isFeatured'] as bool,
      expirationsMonths: json['expirationsMonths'] as int,
      isOrganic: json['isOrganic'] as bool,
      numberOfCalories: json['numberOfCalories'] as int,
      unitAmount: json['unitAmount'] as int,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['imageUrl'] as String?,
      sellingCount: json['sellingCount'] as int? ?? 0,
      avgRating: json['avgRating'] as num? ?? 0,
      ratingCount: json['ratingCount'] as num? ?? 0,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      name: name,
      code: code,
      description: description,
      price: price,
      discount: discount,
      isFeatured: isFeatured,
      imageUrl: imageUrl,
      expirationsMonths: expirationsMonths,
      isOrganic: isOrganic,
      numberOfCalories: numberOfCalories,
      unitAmount: unitAmount,
      reviews: reviews.map((review) => review.toEntity()).toList(),
      image: image ?? File(''),
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      name: entity.name,
      code: entity.code,
      description: entity.description,
      price: entity.price,
      discount: entity.discount,
      isFeatured: entity.isFeatured,
      imageUrl: entity.imageUrl,
      expirationsMonths: entity.expirationsMonths,
      isOrganic: entity.isOrganic,
      numberOfCalories: entity.numberOfCalories,
      unitAmount: entity.unitAmount,
      reviews: entity.reviews
          .map((review) => ReviewModel.fromEntity(review))
          .toList(),
      image: entity.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'description': description,
      'price': price,
      'discount': discount,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'expirationsMonths': expirationsMonths,
      'isOrganic': isOrganic,
      'numberOfCalories': numberOfCalories,
      'unitAmount': unitAmount,
      'sellingCount': sellingCount,
      'avgRating': avgRating,
      'ratingCount': ratingCount,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}
