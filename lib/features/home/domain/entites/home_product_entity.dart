import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';

class HomeProductEntity {
  final int? id;
  final String? title;
  final String? slug;
  final int? price;
  final String? description;
  final HomeCategoryEntity? category;
  final List<String>? images;

  const HomeProductEntity({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });
}