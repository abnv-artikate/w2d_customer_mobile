import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/orders/order_pending_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class OrderPendingUseCase extends UseCase<OrderPendingEntity, OrderPendingParams> {
  final Repository _repository;

  OrderPendingUseCase(this._repository);

  @override
  Future<Either<Failure, OrderPendingEntity>> call(OrderPendingParams params) {
    return _repository.orderPending(params);
    // throw UnimplementedError("Check if cart id error is fixed.");
  }
}

class OrderPendingParams {
  final String cartId;
  final int addressId;
  final String quoteToken;
  final double transitInsurance;
  /// platform fees
  final double platformFee;

  /// dest duty
  final double destinationDuty;
  final double vat;

  /// Local transit fees
  final double localTransitFee;
  final String currency;
  final double shippingCost;
  final double productPrice;
  final double sumTotal;
  final String file;
  final String orderRef;

  OrderPendingParams({
    required this.cartId,
    required this.addressId,
    required this.quoteToken,
    required this.transitInsurance,
    required this.platformFee,
    required this.destinationDuty,
    required this.vat,
    required this.localTransitFee,
    required this.currency,
    required this.shippingCost,
    required this.productPrice,
    required this.sumTotal,
    required this.file,
    required this.orderRef,
  });

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      'address_id': addressId,
      'quote_token': quoteToken,
      'transit_insurance': transitInsurance,
      'platform_fee': platformFee,
      'destination_duty': destinationDuty,
      'vat': vat,
      'local_transit_fee': localTransitFee,
      'currency': currency,
      'shipping_cost': shippingCost,
      'product_price': productPrice,
      'sum_total': sumTotal,
      'file': file,
      'order_ref': orderRef,
    };
  }
}
