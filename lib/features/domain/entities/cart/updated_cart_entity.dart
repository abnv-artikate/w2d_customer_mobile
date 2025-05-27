class UpdatedCartEntity {
  String status;
  String message;
  UpdatedCartData cartData;

  UpdatedCartEntity({
    required this.status,
    required this.message,
    required this.cartData,
  });
}

class UpdatedCartData {
  int id;
  dynamic customer;
  String sessionKey;
  String createdAt;

  UpdatedCartData({
    required this.id,
    required this.customer,
    required this.sessionKey,
    required this.createdAt,
  });
}
