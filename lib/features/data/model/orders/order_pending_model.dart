import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/orders/order_pending_entity.dart';

class OrderPendingModel {
  String? status;
  String? message;
  List<OrderPendingModelData>? data;

  OrderPendingModel({this.status, this.message, this.data});

  factory OrderPendingModel.fromRawJson(String str) =>
      OrderPendingModel.fromJson(json.decode(str));

  factory OrderPendingModel.fromJson(Map<String, dynamic> json) =>
      OrderPendingModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<OrderPendingModelData>.from(
                  json["data"]!.map((x) => OrderPendingModelData.fromJson(x)),
                ),
      );

  OrderPendingEntity toEntity() {
    return OrderPendingEntity(
      status: status ?? "",
      message: message ?? "",
      data: data?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class OrderPendingModelData {
  String? store;
  String? authKey;
  String? orderId;
  int? sellerId;
  String? subtotal;
  String? total;

  OrderPendingModelData({
    this.store,
    this.authKey,
    this.orderId,
    this.sellerId,
    this.subtotal,
    this.total,
  });

  factory OrderPendingModelData.fromRawJson(String str) =>
      OrderPendingModelData.fromJson(json.decode(str));

  factory OrderPendingModelData.fromJson(Map<String, dynamic> json) =>
      OrderPendingModelData(
        store: json["store"],
        authKey: json["authkey"],
        orderId: json["order_id"],
        sellerId: json["seller_id"],
        subtotal: json["subtotal"],
        total: json["total"],
      );

  OrderPendingData toEntity() {
    return OrderPendingData(
      store: store ?? "",
      authKey: authKey ?? "",
      orderId: orderId ?? "",
      sellerId: sellerId ?? -1,
      subtotal: subtotal ?? "",
      total: total ?? "",
    );
  }
}
