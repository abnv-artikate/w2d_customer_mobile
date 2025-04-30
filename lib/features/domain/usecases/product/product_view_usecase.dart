import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class ProductViewUseCase extends UseCase<ProductViewEntity, ProductViewParams> {
  final Repository _repository;

  ProductViewUseCase(this._repository);

  @override
  Future<Either<Failure, ProductViewEntity>> call(
      ProductViewParams params,
  ) async {
    return _repository.getProductView(params: params);
  }
}

class ProductViewParams {
  final String productId;

  ProductViewParams({required this.productId});
}
