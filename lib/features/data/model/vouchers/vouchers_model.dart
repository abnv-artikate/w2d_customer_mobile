import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/vouchers/vouchers_entity.dart';

class VouchersModel {
  String? code;
  String? title;
  String? description;
  String? discountType;
  int? discountValue;
  double? minSpent;

  VouchersModel({
    this.code,
    this.title,
    this.description,
    this.discountType,
    this.discountValue,
    this.minSpent,
  });

  factory VouchersModel.fromRawJson(String str) =>
      VouchersModel.fromJson(json.decode(str));

  factory VouchersModel.fromJson(Map<String, dynamic> json) => VouchersModel(
    code: json["code"],
    title: json["title"],
    description: json["description"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    minSpent: json["min_spent"],
  );

  VouchersEntity toEntity() {
    return VouchersEntity(
      code: code ?? "",
      title: title ?? "",
      description: description ?? "",
      discountType: discountType ?? "",
      discountValue: discountValue ?? 0,
      minSpent: minSpent ?? 0.0,
    );
  }
}
