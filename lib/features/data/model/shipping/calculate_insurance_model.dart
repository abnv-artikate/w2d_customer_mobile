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

  String toRawJson() => json.encode(toJson());

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

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "info": info,
    "message": message,
    "data": data?.toJson(),
  };
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

  String toRawJson() => json.encode(toJson());

  factory CalculateInsuranceModelData.fromJson(Map<String, dynamic> json) =>
      CalculateInsuranceModelData(
        goodsValue: json["goods_value"],
        freightAmount: json["freight_amount"],
        insuranceAmt: json["insurance_amt"],
        totalDutyTax: json["total_duty_tax"],
        netTotal: json["net_total"],
      );

  Map<String, dynamic> toJson() => {
    "goods_value": goodsValue,
    "freight_amount": freightAmount,
    "insurance_amt": insuranceAmt,
    "total_duty_tax": totalDutyTax,
    "net_total": netTotal,
  };
}
