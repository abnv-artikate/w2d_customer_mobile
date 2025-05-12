import 'dart:convert';

class ConfirmInsuranceModel {
  int? code;
  bool? status;
  String? info;
  String? message;
  ConfirmInsuranceModelData? data;

  ConfirmInsuranceModel({
    this.code,
    this.status,
    this.info,
    this.message,
    this.data,
  });

  factory ConfirmInsuranceModel.fromRawJson(String str) => ConfirmInsuranceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfirmInsuranceModel.fromJson(Map<String, dynamic> json) => ConfirmInsuranceModel(
    code: json["code"],
    status: json["status"],
    info: json["info"],
    message: json["message"],
    data: json["data"] == null ? null : ConfirmInsuranceModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "info": info,
    "message": message,
    "data": data?.toJson(),
  };
}

class ConfirmInsuranceModelData {
  int? freightAmount;
  int? insuranceAmt;
  String? totalDutyTax;
  int? netTotal;

  ConfirmInsuranceModelData({
    this.freightAmount,
    this.insuranceAmt,
    this.totalDutyTax,
    this.netTotal,
  });

  factory ConfirmInsuranceModelData.fromRawJson(String str) => ConfirmInsuranceModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfirmInsuranceModelData.fromJson(Map<String, dynamic> json) => ConfirmInsuranceModelData(
    freightAmount: json["freight_amount"],
    insuranceAmt: json["insurance_amt"],
    totalDutyTax: json["total_duty_tax"],
    netTotal: json["net_total"],
  );

  Map<String, dynamic> toJson() => {
    "freight_amount": freightAmount,
    "insurance_amt": insuranceAmt,
    "total_duty_tax": totalDutyTax,
    "net_total": netTotal,
  };
}
