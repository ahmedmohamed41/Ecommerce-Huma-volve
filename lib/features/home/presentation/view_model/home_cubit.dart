import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/home_category_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/home_product_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoryUseCase homeCategoryUseCase;
  final GetProductUseCase homeProductUseCase;
  HomeCubit(this.homeCategoryUseCase, this.homeProductUseCase)
    : super(HomeInitial());

  void loadHomeData() async {
    int cateoryId = 0;
    emit(CategoriesLoading());
    final categories = await homeCategoryUseCase.call();

    categories.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
      },
      (categories) {
        cateoryId = categories[0].id ?? 0;
        emit(CategoriesSuccess(categories));
      },
    );

    final products = await homeProductUseCase.call(cateoryId);
    products.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }

  void getProductsByCategory(int categoryId) async {
    emit(ProductsLoading());

    final products = await homeProductUseCase.call(categoryId);
    products.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }
}
