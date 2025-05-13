import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetCartUseCase extends UseCase<CartEntity, NoParams> {
  final Repository _repository;

  GetCartUseCase(this._repository);

  @override
  Future<Either<Failure, CartEntity>> call(NoParams params) async {
    return await _repository.getCart();
  }
}

class GetCartParams {
  final String cartId;

  GetCartParams({this.cartId = ""});
}
