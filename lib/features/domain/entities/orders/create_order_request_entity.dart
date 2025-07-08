class CreateOrderRequestEntity {
  final String cartId;
  final int addressId;
  final String quoteToken;
  final int transitInsurance;
  final double platformFee;
  final double destinationDuty;
  final double vat;
  final double localTransitFee;
  final String currency;
  final double shippingCost;
  final double productPrice;
  final double sumTotal;
  final String file;
  final String orderRef;

  CreateOrderRequestEntity({
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

  factory CreateOrderRequestEntity.fromJson(Map<String, dynamic> json) {
    return CreateOrderRequestEntity(
      cartId: json['cart_id'],
      addressId: json['address_id'],
      quoteToken: json['quote_token'],
      transitInsurance: json['transit_insurance'],
      platformFee: (json['platform_fee'] as num).toDouble(),
      destinationDuty: (json['destination_duty'] as num).toDouble(),
      vat: (json['vat'] as num).toDouble(),
      localTransitFee: (json['local_transit_fee'] as num).toDouble(),
      currency: json['currency'],
      shippingCost: (json['shipping_cost'] as num).toDouble(),
      productPrice: (json['product_price'] as num).toDouble(),
      sumTotal: (json['sum_total'] as num).toDouble(),
      file: json['file'],
      orderRef: json['order_ref'],
    );
  }

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
