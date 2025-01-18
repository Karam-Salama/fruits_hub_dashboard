import 'dart:io';

import 'package:fruits_hub_dashboard/modules/add_product/data/models/review_model.dart';

import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String name;
  final String code;
  final String description;
  final num price;
  final num discount;
  final File image;
  final bool isFeatured;
  String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final num avgRating = 0;
  final num ratingCount = 0;
  final int unitAmount;
  final int sellingCount;
  final List<ReviewModel> reviews;

  ProductModel({
    required this.name,
      required this.code,
      required this.description,
      required this.expirationsMonths,
      required this.numberOfCalories,
      required this.unitAmount,
      required this.reviews,
      required this.price,
      required this.discount,
      this.sellingCount = 0,
      required this.isOrganic,
      required this.image,
      required this.isFeatured,
      this.imageUrl
  });


  factory ProductModel.fromEntity(ProductEntity addProductEntity) {
    return ProductModel(
      reviews: addProductEntity.reviews
          .map((e) => ReviewModel.fromEntity(e))
          .toList(),
      name: addProductEntity.name,
      description: addProductEntity.description,
      code: addProductEntity.code,
      price: addProductEntity.price,
      discount: addProductEntity.discount,
      image: addProductEntity.image,
      isFeatured: addProductEntity.isFeatured,
      imageUrl: addProductEntity.imageUrl,
      unitAmount: addProductEntity.unitAmount,
      expirationsMonths: addProductEntity.expirationsMonths,
      numberOfCalories: addProductEntity.numberOfCalories,
      isOrganic: addProductEntity.isOrganic,
    );
  }

  toJson() {
    return {
      'name': name,
      'code': code,
      'sellingCount': sellingCount,
      'description': description,
      'price': price,
      'isFeatured': isFeatured,
      'imageUrl': imageUrl,
      'expirationsMonths': expirationsMonths,
      'numberOfCalories': numberOfCalories,
      'unitAmount': unitAmount,
      'discount': discount,
      'isOrganic': isOrganic,
      'reviews': reviews.map((e) => e.toJson()).toList()
    };
  }
}

