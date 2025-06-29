import '../../domain/entities/review_entity.dart';

class ReviewModel {
  final String name;
  final String image;
  final num rating;
  final String date;
  final String reviewDescription;

  ReviewModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.date,
    required this.reviewDescription,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json['name'] as String,
      image: json['image'] as String,
      rating: json['rating'] as num,
      date: json['date'] as String,
      reviewDescription: json['reviewDescription'] as String,
    );
  }

  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      name: entity.name,
      image: entity.image,
      rating: entity.ratting,
      date: entity.date,
      reviewDescription: entity.reviewDescription,
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      name: name,
      image: image,
      ratting: rating,
      date: date,
      reviewDescription: reviewDescription,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'rating': rating,
      'date': date,
      'reviewDescription': reviewDescription,
    };
  }
}
