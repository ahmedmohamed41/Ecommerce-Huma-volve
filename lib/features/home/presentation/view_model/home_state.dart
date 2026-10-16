import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoriesSuccess extends HomeState {
  List<HomeCategoryEntity> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesLoading extends HomeState {}

class CategoriesError extends HomeState {
  final String errorMessage;
  CategoriesError(this.errorMessage);
}

class ProductsSuccess extends HomeState {
  List<HomeProductEntity> products;
  ProductsSuccess(this.products);
}

class ProductsLoading extends HomeState {}

class ProductsError extends HomeState {
  final String errorMessage;
  ProductsError(this.errorMessage);
}

class ProductsLoadingMore extends HomeState {}

class ProductsLoadingError extends HomeState {
  final String errorMessage;
  ProductsLoadingError(this.errorMessage);
}
