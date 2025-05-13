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

  factory FreightQuoteModel.fromRawJson(String str) => FreightQuoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FreightQuoteModel.fromJson(Map<String, dynamic> json) => FreightQuoteModel(
    code: json["code"],
    status: json["status"],
    info: json["info"],
    message: json["message"],
    data: json["data"] == null ? null : FreightQuoteModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "info": info,
    "message": message,
    "data": data?.toJson(),
  };
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

  factory FreightQuoteModelData.fromRawJson(String str) => FreightQuoteModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FreightQuoteModelData.fromJson(Map<String, dynamic> json) => FreightQuoteModelData(
    quoteToken: json["quote_token"],
    quoteAir: json["quote_air"] == null ? null : Quote.fromJson(json["quote_air"]),
    quoteSea: json["quote_sea"] == null ? null : Quote.fromJson(json["quote_sea"]),
    quoteCourier: json["quote_courier"] == null ? null : DataQuoteCourier.fromJson(json["quote_courier"]),
    quoteLand: json["quote_land"] == null ? null : DataQuoteLand.fromJson(json["quote_land"]),
  );

  Map<String, dynamic> toJson() => {
    "quote_token": quoteToken,
    "quote_air": quoteAir?.toJson(),
    "quote_sea": quoteSea?.toJson(),
    "quote_courier": quoteCourier?.toJson(),
    "quote_land": quoteLand?.toJson(),
  };
}

class Quote {
  TentacledPortDelivery? portDelivery;
  IndigoDoorDelivery? doorDelivery;

  Quote({
    this.portDelivery,
    this.doorDelivery,
  });

  factory Quote.fromRawJson(String str) => Quote.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    portDelivery: json["port_delivery"] == null ? null : TentacledPortDelivery.fromJson(json["port_delivery"]),
    doorDelivery: json["door_delivery"] == null ? null : IndigoDoorDelivery.fromJson(json["door_delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "port_delivery": portDelivery?.toJson(),
    "door_delivery": doorDelivery?.toJson(),
  };
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

  factory IndigoDoorDelivery.fromRawJson(String str) => IndigoDoorDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndigoDoorDelivery.fromJson(Map<String, dynamic> json) => IndigoDoorDelivery(
    message: json["message"],
    totalAmount: json["total_amount"],
    totalDutyTax: json["total_duty_tax"],
    doorGrantTotal: json["door_grant_total"],
    doorDeliveryTt: json["door_delivery_tt"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "total_amount": totalAmount,
    "total_duty_tax": totalDutyTax,
    "door_grant_total": doorGrantTotal,
    "door_delivery_tt": doorDeliveryTt,
  };
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

  factory TentacledPortDelivery.fromRawJson(String str) => TentacledPortDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TentacledPortDelivery.fromJson(Map<String, dynamic> json) => TentacledPortDelivery(
    message: json["message"],
    totalAmount: json["total_amount"],
    totalDutyTax: json["total_duty_tax"],
    portGrantTotal: json["port_grant_total"],
    portDeliveryTt: json["port_delivery_tt"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "total_amount": totalAmount,
    "total_duty_tax": totalDutyTax,
    "port_grant_total": portGrantTotal,
    "port_delivery_tt": portDeliveryTt,
  };
}

class DataQuoteCourier {
  IndecentDoorDelivery? doorDelivery;

  DataQuoteCourier({
    this.doorDelivery,
  });

  factory DataQuoteCourier.fromRawJson(String str) => DataQuoteCourier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataQuoteCourier.fromJson(Map<String, dynamic> json) => DataQuoteCourier(
    doorDelivery: json["door_delivery"] == null ? null : IndecentDoorDelivery.fromJson(json["door_delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "door_delivery": doorDelivery?.toJson(),
  };
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

  factory IndecentDoorDelivery.fromRawJson(String str) => IndecentDoorDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndecentDoorDelivery.fromJson(Map<String, dynamic> json) => IndecentDoorDelivery(
    doorDeliveryTt: json["door_delivery_tt"],
    message: json["message"],
    totalAmount: json["total_amount"],
    totalDutyTax: json["total_duty_tax"],
    doorGrantTotal: json["door_grant_total"],
  );

  Map<String, dynamic> toJson() => {
    "door_delivery_tt": doorDeliveryTt,
    "message": message,
    "total_amount": totalAmount,
    "total_duty_tax": totalDutyTax,
    "door_grant_total": doorGrantTotal,
  };
}

class DataQuoteLand {
  IndigoDoorDelivery? doorDelivery;

  DataQuoteLand({
    this.doorDelivery,
  });

  factory DataQuoteLand.fromRawJson(String str) => DataQuoteLand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataQuoteLand.fromJson(Map<String, dynamic> json) => DataQuoteLand(
    doorDelivery: json["door_delivery"] == null ? null : IndigoDoorDelivery.fromJson(json["door_delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "door_delivery": doorDelivery?.toJson(),
  };
}
