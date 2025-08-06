import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/orders/orders_list_entity.dart';

class OrderListModel {
  int? count;
  dynamic next;
  dynamic previous;
  OrderResultsModel? results;

  OrderListModel({this.count, this.next, this.previous, this.results});

  factory OrderListModel.fromRawJson(String str) =>
      OrderListModel.fromJson(json.decode(str));

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results:
        json["results"] == null
            ? null
            : OrderResultsModel.fromJson(json["results"]),
  );
}

class OrderResultsModel {
  String? status;
  String? message;
  List<OrderResultDataModel>? data;

  OrderResultsModel({this.status, this.message, this.data});

  factory OrderResultsModel.fromRawJson(String str) =>
      OrderResultsModel.fromJson(json.decode(str));

  factory OrderResultsModel.fromJson(Map<String, dynamic> json) =>
      OrderResultsModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<OrderResultDataModel>.from(
                  json["data"]!.map((x) => OrderResultDataModel.fromJson(x)),
                ),
      );

  OrderListEntity toEntity() {
    return OrderListEntity(
      status: status ?? "",
      message: message ?? "",
      data: data?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class OrderResultDataModel {
  String? id;
  List<OrderResultDataItemModel>? items;

  OrderResultDataModel({
    this.id,
    this.items,
  });

  factory OrderResultDataModel.fromRawJson(String str) =>
      OrderResultDataModel.fromJson(json.decode(str));

  factory OrderResultDataModel.fromJson(Map<String, dynamic> json) =>
      OrderResultDataModel(
        id: json["id"],
        items:
            json["items"] == null
                ? []
                : List<OrderResultDataItemModel>.from(
                  json["items"]!.map(
                    (x) => OrderResultDataItemModel.fromJson(x),
                  ),
                ),
      );

  OrderListDataEntity toEntity() {
    return OrderListDataEntity(
      id: id ?? "",
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class OrderResultDataCustomerModel {
  String? email;
  String? fullName;
  dynamic mobileNumber;
  dynamic secondaryMobileNumber;
  String? country;

  OrderResultDataCustomerModel({
    this.email,
    this.fullName,
    this.mobileNumber,
    this.secondaryMobileNumber,
    this.country,
  });

  factory OrderResultDataCustomerModel.fromRawJson(String str) =>
      OrderResultDataCustomerModel.fromJson(json.decode(str));

  factory OrderResultDataCustomerModel.fromJson(Map<String, dynamic> json) =>
      OrderResultDataCustomerModel(
        email: json["email"],
        fullName: json["full_name"],
        mobileNumber: json["mobile_number"],
        secondaryMobileNumber: json["secondary_mobile_number"],
        country: json["country"],
      );
}

class OrderResultDataItemModel {
  String? id;
  String? readableId;
  String? status;
  String? productName;
  String? variantName;
  int? quantity;
  String? unitPrice;
  String? totalPrice;

  OrderResultDataItemModel({
    this.id,
    this.readableId,
    this.status,
    this.productName,
    this.variantName,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
  });

  factory OrderResultDataItemModel.fromRawJson(String str) =>
      OrderResultDataItemModel.fromJson(json.decode(str));

  factory OrderResultDataItemModel.fromJson(Map<String, dynamic> json) =>
      OrderResultDataItemModel(
        id: json["id"],
        readableId: json["readable_id"],
        status: json["status"],
        productName: json["product_name"],
        variantName: json["variant_name"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        totalPrice: json["total_price"],
      );

  OrderListDataItemEntity toEntity() {
    return OrderListDataItemEntity(
      id: id ?? "",
      readableId: readableId ?? "",
      status: status ?? "",
      productName: productName ?? "",
      variantName: variantName ?? "",
      quantity: quantity ?? -1,
      unitPrice: unitPrice ?? "",
      totalPrice: totalPrice ?? "",
    );
  }
}


