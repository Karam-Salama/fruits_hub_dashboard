import 'dart:io';

import 'package:fruits_hub_dashboard/modules/add_product/data/models/review_model.dart';

import '../../domain/entities/add_product_entity.dart';

class AddProductInputModel {
  final String name;
  final String description;
  final String code;
  final num price;
  final num discount;
  final File image;
  final bool isFeatured;
  String? imageUrl;
  final int expirationMonths;
  bool isOrganic;
  final int numberOfCalories;
  final num avgRating = 0;
  final num ratingCount = 0;
  final int unitAmount;
  final List<ReviewModel> reviews;

  AddProductInputModel(
      {required this.name,
      required this.description,
      required this.code,
      required this.unitAmount,
      required this.expirationMonths,
      required this.numberOfCalories,
      required this.price,
      required this.reviews,
      required this.discount,
      required this.image,
      required this.isFeatured,
      this.imageUrl,
      required this.isOrganic});

  factory AddProductInputModel.fromEntity(AddProductEntity addProductEntity) {
    return AddProductInputModel(
      reviews: addProductEntity.reviews.map((e) => ReviewModel.fromEntity(e)).toList(),
      name: addProductEntity.name,
      description: addProductEntity.description,
      code: addProductEntity.code,
      price: addProductEntity.price,
      discount: addProductEntity.discount,
      image: addProductEntity.image,
      isFeatured: addProductEntity.isFeatured,
      imageUrl: addProductEntity.imageUrl,
      unitAmount: addProductEntity.unitAmount,
      expirationMonths: addProductEntity.expirationMonths,
      numberOfCalories: addProductEntity.numberOfCalories,
      isOrganic: addProductEntity.isOrganic,
    );
  }
  toJson() {
    return {
      'name': name,
      'description': description,
      'code': code,
      'price': price,
      'discount': discount,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'unitAmount': unitAmount,
      'expirationMonths': expirationMonths,
      'numberOfCalories': numberOfCalories,
      'isOrganic': isOrganic,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}
