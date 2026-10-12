import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoriesSuccess extends HomeState {
  List<CategoryModel> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesLoading extends HomeState {}

class CategoriesError extends HomeState {
  final String errorMessage;
  CategoriesError(this.errorMessage);
}

class ProductsSuccess extends HomeState {
  List<ProductModel> products;
  ProductsSuccess(this.products);
}

class ProductsLoading extends HomeState {}

class ProductsError extends HomeState {
  final String errorMessage;
  ProductsError(this.errorMessage);
}
