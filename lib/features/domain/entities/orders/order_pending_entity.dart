class OrderPendingEntity {
  final String status;
  final String message;
  final List<OrderPendingData> data;

  OrderPendingEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class OrderPendingData {
  final String store;
  final String authKey;
  final String orderId;
  final int sellerId;
  final String subtotal;
  final String total;

  OrderPendingData({
    required this.store,
    required this.authKey,
    required this.orderId,
    required this.sellerId,
    required this.subtotal,
    required this.total,
  });
}
