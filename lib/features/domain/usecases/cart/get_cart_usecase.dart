import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetCartUseCase extends UseCase<CartEntity, GetCartParams> {
  final Repository _repository;

  GetCartUseCase(this._repository);

  @override
  Future<Either<Failure, CartEntity>> call(GetCartParams params) async {
    return await _repository.getCart(params: params);
  }
}

class GetCartParams {
  final String cartId;

  GetCartParams({required this.cartId});
}
