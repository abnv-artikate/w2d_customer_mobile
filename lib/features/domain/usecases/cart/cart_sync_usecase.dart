import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class CartSyncUseCase extends UseCase<String, CartSyncParams> {
  final Repository _repository;

  CartSyncUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(CartSyncParams params) async {
    return await _repository.cartSync(params: params);
  }
}

class CartSyncParams {
  final String productId;
  final String variantId;
  final int quantity;

  CartSyncParams({
    required this.productId,
    this.variantId = "",
    required this.quantity,
  });
}
