import 'dart:convert';

class SelectFreightQuoteModel {
  int? code;
  bool? status;
  String? info;
  String? message;
  SelectFreightQuoteModelData? data;

  SelectFreightQuoteModel({
    this.code,
    this.status,
    this.info,
    this.message,
    this.data,
  });

  factory SelectFreightQuoteModel.fromRawJson(String str) => SelectFreightQuoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectFreightQuoteModel.fromJson(Map<String, dynamic> json) => SelectFreightQuoteModel(
    code: json["code"],
    status: json["status"],
    info: json["info"],
    message: json["message"],
    data: json["data"] == null ? null : SelectFreightQuoteModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "info": info,
    "message": message,
    "data": data?.toJson(),
  };
}

class SelectFreightQuoteModelData {
  int? amount;

  SelectFreightQuoteModelData({
    this.amount,
  });

  factory SelectFreightQuoteModelData.fromRawJson(String str) => SelectFreightQuoteModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectFreightQuoteModelData.fromJson(Map<String, dynamic> json) => SelectFreightQuoteModelData(
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
  };
}
