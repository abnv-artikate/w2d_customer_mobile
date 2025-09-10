import 'dart:convert';

class CalculateInsuranceModel {
  int? code;
  bool? status;
  String? info;
  String? message;
  CalculateInsuranceModelData? data;

  CalculateInsuranceModel({
    this.code,
    this.status,
    this.info,
    this.message,
    this.data,
  });

  factory CalculateInsuranceModel.fromRawJson(String str) =>
      CalculateInsuranceModel.fromJson(json.decode(str));

  factory CalculateInsuranceModel.fromJson(Map<String, dynamic> json) =>
      CalculateInsuranceModel(
        code: json["code"],
        status: json["status"],
        info: json["info"],
        message: json["message"],
        data:
            json["data"] == null
                ? null
                : CalculateInsuranceModelData.fromJson(json["data"]),
      );
}

class CalculateInsuranceModelData {
  double? goodsValue;
  double? freightAmount;
  double? insuranceAmt;
  dynamic totalDutyTax;
  double? netTotal;

  CalculateInsuranceModelData({
    this.goodsValue,
    this.freightAmount,
    this.insuranceAmt,
    this.totalDutyTax,
    this.netTotal,
  });

  factory CalculateInsuranceModelData.fromRawJson(String str) =>
      CalculateInsuranceModelData.fromJson(json.decode(str));

  factory CalculateInsuranceModelData.fromJson(Map<String, dynamic> json) =>
      CalculateInsuranceModelData(
        goodsValue: double.tryParse(json["goods_value"].toString()) ?? 0.0,
        freightAmount:
            double.tryParse(json["freight_amount"].toString()) ?? 0.0,
        insuranceAmt: double.tryParse(json["insurance_amt"].toString()) ?? 0.0,
        totalDutyTax: double.tryParse(json["total_duty_tax"].toString()) ?? 0.0,
        netTotal: double.tryParse(json["net_total"].toString()) ?? 0.0,
      );
}
