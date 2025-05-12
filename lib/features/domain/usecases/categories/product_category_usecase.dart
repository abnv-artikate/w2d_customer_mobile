import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class ProductCategoryUseCase
    extends UseCase<ProductCategoryListingEntity, ProductCategoryParams> {
  final Repository _repository;

  ProductCategoryUseCase(this._repository);

  @override
  Future<Either<Failure, ProductCategoryListingEntity>> call(
    ProductCategoryParams params,
  ) async {
    return await _repository.getProductCategoryListing(params: params);
  }
}

class ProductCategoryParams {
  final String categorySlug;

  ProductCategoryParams({required this.categorySlug});
}
