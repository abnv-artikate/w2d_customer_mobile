import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/vouchers/validate_voucher_entity.dart';

class ValidateVoucherModel {
  String? message;
  String? voucherType;
  String? code;
  String? name;
  String? discountType;
  double? discountValue;
  String? currency;

  ValidateVoucherModel({
    this.message,
    this.voucherType,
    this.code,
    this.name,
    this.discountType,
    this.discountValue,
    this.currency,
  });

  factory ValidateVoucherModel.fromRawJson(String str) =>
      ValidateVoucherModel.fromJson(json.decode(str));

  factory ValidateVoucherModel.fromJson(Map<String, dynamic> json) =>
      ValidateVoucherModel(
        message: json["message"],
        voucherType: json["voucher_type"],
        code: json["code"],
        name: json["name"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        currency: json["currency"],
      );

  ValidateVoucherEntity toEntity() {
    return ValidateVoucherEntity(
      message: message ?? "",
      voucherType: voucherType ?? "",
      code: code ?? "",
      name: name ?? "",
      discountType: discountType ?? "",
      discountValue: discountValue ?? 0.0,
      currency: currency ?? "",
    );
  }
}
