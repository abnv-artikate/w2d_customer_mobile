import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/browsing_history/browsing_history_entity.dart';

class BrowsingHistoryModel {
  String? status;
  String? message;
  List<BrowsingHistoryDataModel>? data;

  BrowsingHistoryModel({this.status, this.message, this.data});

  factory BrowsingHistoryModel.fromRawJson(String str) =>
      BrowsingHistoryModel.fromJson(json.decode(str));

  factory BrowsingHistoryModel.fromJson(Map<String, dynamic> json) =>
      BrowsingHistoryModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<BrowsingHistoryDataModel>.from(
                  json["data"]!.map(
                    (x) => BrowsingHistoryDataModel.fromJson(x),
                  ),
                ),
      );

  BrowsingHistoryEntity toEntity() {
    return BrowsingHistoryEntity(
      status: status ?? "",
      message: message ?? "",
      data: data?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class BrowsingHistoryDataModel {
  int? id;
  dynamic customer;
  BrowsingHistoryDataProductModel? product;
  dynamic variant;
  String? viewedAt;

  BrowsingHistoryDataModel({
    this.id,
    this.customer,
    this.product,
    this.variant,
    this.viewedAt,
  });

  factory BrowsingHistoryDataModel.fromRawJson(String str) =>
      BrowsingHistoryDataModel.fromJson(json.decode(str));

  factory BrowsingHistoryDataModel.fromJson(Map<String, dynamic> json) =>
      BrowsingHistoryDataModel(
        id: json["id"],
        customer: json["customer"],
        product:
            json["product"] == null
                ? null
                : BrowsingHistoryDataProductModel.fromJson(json["product"]),
        variant: json["variant"],
        viewedAt: json["viewed_at"],
      );

  BrowsingHistoryDataEntity toEntity() {
    return BrowsingHistoryDataEntity(
      id: id ?? -1,
      product: product?.toEntity(),
      viewedAt: viewedAt ?? "",
    );
  }
}

class BrowsingHistoryDataProductModel {
  String? id;
  String? name;
  String? mainImage;
  String? regularPrice;
  String? salePrice;

  BrowsingHistoryDataProductModel({
    this.id,
    this.name,
    this.mainImage,
    this.regularPrice,
    this.salePrice,
  });

  factory BrowsingHistoryDataProductModel.fromRawJson(String str) =>
      BrowsingHistoryDataProductModel.fromJson(json.decode(str));

  factory BrowsingHistoryDataProductModel.fromJson(Map<String, dynamic> json) =>
      BrowsingHistoryDataProductModel(
        id: json["id"],
        name: json["name"],
        mainImage: json["main_image"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
      );

  BrowsingHistoryDataProductEntity toEntity() {
    return BrowsingHistoryDataProductEntity(
      id: id ?? "",
      name: name ?? "",
      mainImage: mainImage ?? "",
      regularPrice: regularPrice ?? "",
      salePrice: salePrice ?? "",
    );
  }
}
