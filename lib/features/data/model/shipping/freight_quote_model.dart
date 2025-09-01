import 'dart:convert';

class FreightQuoteModel {
  int? code;
  bool? status;
  String? info;
  String? message;
  FreightQuoteModelData? data;

  FreightQuoteModel({
    this.code,
    this.status,
    this.info,
    this.message,
    this.data,
  });

  factory FreightQuoteModel.fromRawJson(String str) =>
      FreightQuoteModel.fromJson(json.decode(str));

  factory FreightQuoteModel.fromJson(Map<String, dynamic> json) =>
      FreightQuoteModel(
        code: json["code"],
        status: json["status"],
        info: json["info"],
        message: json["message"],
        data:
            json["data"] == null
                ? null
                : FreightQuoteModelData.fromJson(json["data"]),
      );
}

class FreightQuoteModelData {
  String? quoteToken;
  Quote? quoteAir;
  Quote? quoteSea;
  DataQuoteCourier? quoteCourier;
  DataQuoteLand? quoteLand;

  FreightQuoteModelData({
    this.quoteToken,
    this.quoteAir,
    this.quoteSea,
    this.quoteCourier,
    this.quoteLand,
  });

  factory FreightQuoteModelData.fromRawJson(String str) =>
      FreightQuoteModelData.fromJson(json.decode(str));

  factory FreightQuoteModelData.fromJson(
    Map<String, dynamic> json,
  ) => FreightQuoteModelData(
    quoteToken: json["quote_token"],
    quoteAir:
        json["quote_air"] == null ? null : Quote.fromJson(json["quote_air"]),
    quoteSea:
        json["quote_sea"] == null ? null : Quote.fromJson(json["quote_sea"]),
    quoteCourier:
        json["quote_courier"] == null
            ? null
            : DataQuoteCourier.fromJson(json["quote_courier"]),
    quoteLand:
        json["quote_land"] == null
            ? null
            : DataQuoteLand.fromJson(json["quote_land"]),
  );
}

class Quote {
  TentacledPortDelivery? portDelivery;
  IndigoDoorDelivery? doorDelivery;

  Quote({this.portDelivery, this.doorDelivery});

  factory Quote.fromRawJson(String str) => Quote.fromJson(json.decode(str));

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    portDelivery:
        json["port_delivery"] == null
            ? null
            : TentacledPortDelivery.fromJson(json["port_delivery"]),
    doorDelivery:
        json["door_delivery"] == null
            ? null
            : IndigoDoorDelivery.fromJson(json["door_delivery"]),
  );
}

class IndigoDoorDelivery {
  String? message;
  int? totalAmount;
  String? totalDutyTax;
  int? doorGrantTotal;
  int? doorDeliveryTt;

  IndigoDoorDelivery({
    this.message,
    this.totalAmount,
    this.totalDutyTax,
    this.doorGrantTotal,
    this.doorDeliveryTt,
  });

  factory IndigoDoorDelivery.fromRawJson(String str) =>
      IndigoDoorDelivery.fromJson(json.decode(str));

  factory IndigoDoorDelivery.fromJson(Map<String, dynamic> json) =>
      IndigoDoorDelivery(
        message: json["message"],
        totalAmount: json["total_amount"],
        totalDutyTax: json["total_duty_tax"],
        doorGrantTotal: json["door_grant_total"],
        doorDeliveryTt: json["door_delivery_tt"],
      );
}

class TentacledPortDelivery {
  String? message;
  int? totalAmount;
  String? totalDutyTax;
  int? portGrantTotal;
  int? portDeliveryTt;

  TentacledPortDelivery({
    this.message,
    this.totalAmount,
    this.totalDutyTax,
    this.portGrantTotal,
    this.portDeliveryTt,
  });

  factory TentacledPortDelivery.fromRawJson(String str) =>
      TentacledPortDelivery.fromJson(json.decode(str));

  factory TentacledPortDelivery.fromJson(Map<String, dynamic> json) =>
      TentacledPortDelivery(
        message: json["message"],
        totalAmount: json["total_amount"],
        totalDutyTax: json["total_duty_tax"],
        portGrantTotal: json["port_grant_total"],
        portDeliveryTt: json["port_delivery_tt"],
      );
}

class DataQuoteCourier {
  IndecentDoorDelivery? doorDelivery;

  DataQuoteCourier({this.doorDelivery});

  factory DataQuoteCourier.fromRawJson(String str) =>
      DataQuoteCourier.fromJson(json.decode(str));

  factory DataQuoteCourier.fromJson(Map<String, dynamic> json) =>
      DataQuoteCourier(
        doorDelivery:
            json["door_delivery"] == null
                ? null
                : IndecentDoorDelivery.fromJson(json["door_delivery"]),
      );
}

class IndecentDoorDelivery {
  String? doorDeliveryTt;
  String? message;
  int? totalAmount;
  String? totalDutyTax;
  int? doorGrantTotal;

  IndecentDoorDelivery({
    this.doorDeliveryTt,
    this.message,
    this.totalAmount,
    this.totalDutyTax,
    this.doorGrantTotal,
  });

  factory IndecentDoorDelivery.fromRawJson(String str) =>
      IndecentDoorDelivery.fromJson(json.decode(str));

  factory IndecentDoorDelivery.fromJson(Map<String, dynamic> json) =>
      IndecentDoorDelivery(
        doorDeliveryTt: json["door_delivery_tt"],
        message: json["message"],
        totalAmount: json["total_amount"],
        totalDutyTax: json["total_duty_tax"],
        doorGrantTotal: json["door_grant_total"],
      );
}

class DataQuoteLand {
  IndigoDoorDelivery? doorDelivery;

  DataQuoteLand({this.doorDelivery});

  factory DataQuoteLand.fromRawJson(String str) =>
      DataQuoteLand.fromJson(json.decode(str));

  factory DataQuoteLand.fromJson(Map<String, dynamic> json) => DataQuoteLand(
    doorDelivery:
        json["door_delivery"] == null
            ? null
            : IndigoDoorDelivery.fromJson(json["door_delivery"]),
  );
}
