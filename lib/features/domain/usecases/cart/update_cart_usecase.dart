import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/updated_cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class UpdateCartUseCase extends UseCase<UpdatedCartEntity, UpdateCartParams> {
  final Repository repository;

  UpdateCartUseCase(this.repository);

  @override
  Future<Either<Failure, UpdatedCartEntity>> call(
    UpdateCartParams params,
  ) async {
    return await repository.updateCart(params: params);
  }
}

class UpdateCartParams {
  final int cartId;
  final String productId;
  final int quantity;
  final bool checked;

  UpdateCartParams({
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.checked,
  });
}

// {"cart_id":1286,"product_id":"909f1459-1a4a-455b-9eb9-f8c1ae55c8e7","quantity":2,"checked":false}
