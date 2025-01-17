import 'dart:io';

import 'package:fruits_hub_dashboard/modules/add_product/domain/entities/review_entity.dart';

class AddProductEntity {
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
  final List<ReviewEntity> reviews;


  AddProductEntity({
    required this.name,
    required this.description,
    required this.code,
    required this.price,
    required this.discount,
    required this.expirationMonths,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.image,
    required this.reviews,
    required this.isFeatured,
    this.imageUrl,
    this.isOrganic = false,
  });
}
