class OrderListEntity {
  final String status;
  final String message;
  final List<OrderListDataEntity> data;

  OrderListEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class OrderListDataEntity {
  final String id;
  final List<OrderListDataItemEntity> items;

  OrderListDataEntity({
    required this.id,
    required this.items,
  });
}

class OrderListDataItemEntity {
  final String id;
  final String readableId;
  final String status;
  final String productName;
  final String variantName;
  final int quantity;
  final String unitPrice;
  final String totalPrice;

  OrderListDataItemEntity({
    required this.id,
    required this.readableId,
    required this.status,
    required this.productName,
    required this.variantName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });
}
