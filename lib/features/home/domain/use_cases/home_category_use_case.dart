import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class GetCategoryUseCase {
  final HomeRepository homeRepository;
  GetCategoryUseCase(this.homeRepository);

  Future<Either<Failure, List<HomeCategoryEntity>>> call() =>
      homeRepository.getCategories();
}
