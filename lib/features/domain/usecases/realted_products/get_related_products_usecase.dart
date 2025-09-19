import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/related_products/related_products_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetRelatedProductsUseCase
    extends UseCase<RelatedProductsEntity, GetRelatedProductsParams> {
  final Repository _repository;

  GetRelatedProductsUseCase(this._repository);

  @override
  Future<Either<Failure, RelatedProductsEntity>> call(
    GetRelatedProductsParams params,
  ) {
    return _repository.getRelatedProducts(params.productId);
  }
}

class GetRelatedProductsParams {
  final String productId;

  GetRelatedProductsParams({required this.productId});
}
