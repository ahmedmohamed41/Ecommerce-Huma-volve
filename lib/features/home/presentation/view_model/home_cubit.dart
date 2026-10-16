import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/home_category_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/home_product_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoryUseCase getCategoryUseCase;
  final GetProductUseCase getProductUseCase;

  final int limit = 10;
  int offset = 0;
  bool isLoadindMore = false;
  bool hasMore = true;
  int? selectedCategory;

  final List<HomeProductEntity> _products = [];
  HomeCubit(this.getCategoryUseCase, this.getProductUseCase)
    : super(HomeInitial());

  void loadHomeData() async {
    emit(CategoriesLoading());
    final categories = await getCategoryUseCase.call();
    int cateoryId = 0;
    categories.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
      },
      (categories) {
        cateoryId = categories[0].id ?? 0;
        emit(CategoriesSuccess(categories));
      },
    );

    final products = await getProductUseCase.call(
      cateoryId,
      limit: limit,
      offset: offset,
    );
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
    _products.clear();
    emit(ProductsLoading());
    hasMore = true;
    final products = await getProductUseCase.call(
      categoryId,
      limit: limit,
      offset: offset,
    );
    products.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        _products.addAll(products);
        offset = products.length;
        if (products.length < limit) {
          hasMore = false;
        }
        selectedCategory = categoryId;
        emit(ProductsSuccess(products));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isLoadindMore || hasMore) return;
    isLoadindMore = true;
    emit(ProductsLoadingMore());
    final result = await getProductUseCase.call(
      selectedCategory,
      limit: limit,
      offset: offset,
    );

    result.fold(
      (failure) {
        emit(ProductsLoadingError(failure.failureMessage));
      },
      (r) {
        _products.addAll(r);
        offset += r.length;
        if (r.length < limit) {
          hasMore = false;
        }
        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }
}
