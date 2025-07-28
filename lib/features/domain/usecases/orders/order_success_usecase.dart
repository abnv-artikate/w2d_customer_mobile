import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class OrderSuccessUseCase extends UseCase<String, OrderSuccessParams> {
  final Repository _repository;

  OrderSuccessUseCase(this._repository);
  @override
  Future<Either<Failure, String>> call(OrderSuccessParams params) async {
    return await _repository.orderSuccess(params);
  }
}

class OrderSuccessParams {
  final String paymentReference;
  final String gatewayTxnId;
  final String cartId;

  OrderSuccessParams({
    required this.paymentReference,
    required this.gatewayTxnId,
    required this.cartId,
  });

  Map<String, dynamic> toJson() {
    return {
      "payment_reference": paymentReference,
      "gateway_txn_id": gatewayTxnId,
      "cart_id": cartId,
    };
  }
}
