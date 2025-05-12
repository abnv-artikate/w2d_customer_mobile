import 'dart:convert';

class FreightQuoteModel {
  int? code;
  bool? status;
  String? info;
  String? message;
  FreightQuoteModelData? data;
  Breakdowns? breakdowns;

  FreightQuoteModel({
    this.code,
    this.status,
    this.info,
    this.message,
    this.data,
    this.breakdowns,
  });

  factory FreightQuoteModel.fromRawJson(String str) => FreightQuoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FreightQuoteModel.fromJson(Map<String, dynamic> json) => FreightQuoteModel(
    code: json["code"],
    status: json["status"],
    info: json["info"],
    message: json["message"],
    data: json["data"] == null ? null : FreightQuoteModelData.fromJson(json["data"]),
    breakdowns: json["breakdowns"] == null ? null : Breakdowns.fromJson(json["breakdowns"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "info": info,
    "message": message,
    "data": data?.toJson(),
    "breakdowns": breakdowns?.toJson(),
  };
}

class Breakdowns {
  QuoteAir? quoteAir;
  QuoteSea? quoteSea;
  BreakdownsQuoteCourier? quoteCourier;
  BreakdownsQuoteLand? quoteLand;

  Breakdowns({
    this.quoteAir,
    this.quoteSea,
    this.quoteCourier,
    this.quoteLand,
  });

  factory Breakdowns.fromRawJson(String str) => Breakdowns.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Breakdowns.fromJson(Map<String, dynamic> json) => Breakdowns(
    quoteAir: json["quote_air"] == null ? null : QuoteAir.fromJson(json["quote_air"]),
    quoteSea: json["quote_sea"] == null ? null : QuoteSea.fromJson(json["quote_sea"]),
    quoteCourier: json["quote_courier"] == null ? null : BreakdownsQuoteCourier.fromJson(json["quote_courier"]),
    quoteLand: json["quote_land"] == null ? null : BreakdownsQuoteLand.fromJson(json["quote_land"]),
  );

  Map<String, dynamic> toJson() => {
    "quote_air": quoteAir?.toJson(),
    "quote_sea": quoteSea?.toJson(),
    "quote_courier": quoteCourier?.toJson(),
    "quote_land": quoteLand?.toJson(),
  };
}

class QuoteAir {
  PurplePortDelivery? portDelivery;
  PurpleDoorDelivery? doorDelivery;

  QuoteAir({
    this.portDelivery,
    this.doorDelivery,
  });

  factory QuoteAir.fromRawJson(String str) => QuoteAir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuoteAir.fromJson(Map<String, dynamic> json) => QuoteAir(
    portDelivery: json["port_delivery"] == null ? null : PurplePortDelivery.fromJson(json["port_delivery"]),
    doorDelivery: json["door_delivery"] == null ? null : PurpleDoorDelivery.fromJson(json["door_delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "port_delivery": portDelivery?.toJson(),
    "door_delivery": doorDelivery?.toJson(),
  };
}

class PurpleDoorDelivery {
  double? freightAmnount;
  int? freightFuelAmt;
  int? awbFee;
  String? airHandingCharges;
  int? customDocs;
  String? minHandlingIn;
  String? minHandlingOut;
  int? transportToApt;
  String? destinationCharges;
  double? doorAirlineCharges;
  int? customsClearance;
  int? deliveryOrderFee;
  int? doorDeliveryTt;
  double? totalAmount;
  double? marginAmount;
  int? subTotal;
  AdditionalCharges? additionalCharges;
  int? totalAdditionalCharges;
  String? totalDutyTax;
  int? doorGrantTotal;

  PurpleDoorDelivery({
    this.freightAmnount,
    this.freightFuelAmt,
    this.awbFee,
    this.airHandingCharges,
    this.customDocs,
    this.minHandlingIn,
    this.minHandlingOut,
    this.transportToApt,
    this.destinationCharges,
    this.doorAirlineCharges,
    this.customsClearance,
    this.deliveryOrderFee,
    this.doorDeliveryTt,
    this.totalAmount,
    this.marginAmount,
    this.subTotal,
    this.additionalCharges,
    this.totalAdditionalCharges,
    this.totalDutyTax,
    this.doorGrantTotal,
  });

  factory PurpleDoorDelivery.fromRawJson(String str) => PurpleDoorDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurpleDoorDelivery.fromJson(Map<String, dynamic> json) => PurpleDoorDelivery(
    freightAmnount: json["freight_amnount"]?.toDouble(),
    freightFuelAmt: json["freight_fuel_amt"],
    awbFee: json["awb_fee"],
    airHandingCharges: json["air_handing_charges"],
    customDocs: json["custom_docs"],
    minHandlingIn: json["min_handling_in"],
    minHandlingOut: json["min_handling_out"],
    transportToApt: json["transport_to_apt"],
    destinationCharges: json["destination_charges"],
    doorAirlineCharges: json["door_airline_charges"]?.toDouble(),
    customsClearance: json["customs_clearance"],
    deliveryOrderFee: json["delivery_order_fee"],
    doorDeliveryTt: json["door_delivery_tt"],
    totalAmount: json["total_amount"]?.toDouble(),
    marginAmount: json["margin_amount"]?.toDouble(),
    subTotal: json["sub_total"],
    additionalCharges: json["additional_charges"] == null ? null : AdditionalCharges.fromJson(json["additional_charges"]),
    totalAdditionalCharges: json["total_additional_charges"],
    totalDutyTax: json["total_duty_tax"],
    doorGrantTotal: json["door_grant_total"],
  );

  Map<String, dynamic> toJson() => {
    "freight_amnount": freightAmnount,
    "freight_fuel_amt": freightFuelAmt,
    "awb_fee": awbFee,
    "air_handing_charges": airHandingCharges,
    "custom_docs": customDocs,
    "min_handling_in": minHandlingIn,
    "min_handling_out": minHandlingOut,
    "transport_to_apt": transportToApt,
    "destination_charges": destinationCharges,
    "door_airline_charges": doorAirlineCharges,
    "customs_clearance": customsClearance,
    "delivery_order_fee": deliveryOrderFee,
    "door_delivery_tt": doorDeliveryTt,
    "total_amount": totalAmount,
    "margin_amount": marginAmount,
    "sub_total": subTotal,
    "additional_charges": additionalCharges?.toJson(),
    "total_additional_charges": totalAdditionalCharges,
    "total_duty_tax": totalDutyTax,
    "door_grant_total": doorGrantTotal,
  };
}

class AdditionalCharges {
  Attr? attr;
  int? hsAdditional;
  int? overWeight;

  AdditionalCharges({
    this.attr,
    this.hsAdditional,
    this.overWeight,
  });

  factory AdditionalCharges.fromRawJson(String str) => AdditionalCharges.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalCharges.fromJson(Map<String, dynamic> json) => AdditionalCharges(
    attr: json["attr"] == null ? null : Attr.fromJson(json["attr"]),
    hsAdditional: json["hsAdditional"],
    overWeight: json["overWeight"],
  );

  Map<String, dynamic> toJson() => {
    "attr": attr?.toJson(),
    "hsAdditional": hsAdditional,
    "overWeight": overWeight,
  };
}

class Attr {
  Battery? battery;

  Attr({
    this.battery,
  });

  factory Attr.fromRawJson(String str) => Attr.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
    battery: json["battery"] == null ? null : Battery.fromJson(json["battery"]),
  );

  Map<String, dynamic> toJson() => {
    "battery": battery?.toJson(),
  };
}

class Battery {
  int? dgDeclaration;
  int? dangerousGoodsFee;
  int? dgPacking;
  double? airlineHandling;

  Battery({
    this.dgDeclaration,
    this.dangerousGoodsFee,
    this.dgPacking,
    this.airlineHandling,
  });

  factory Battery.fromRawJson(String str) => Battery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Battery.fromJson(Map<String, dynamic> json) => Battery(
    dgDeclaration: json["dg_declaration"],
    dangerousGoodsFee: json["dangerous_goods_fee"],
    dgPacking: json["dg_packing"],
    airlineHandling: json["airline_handling"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "dg_declaration": dgDeclaration,
    "dangerous_goods_fee": dangerousGoodsFee,
    "dg_packing": dgPacking,
    "airline_handling": airlineHandling,
  };
}

class PurplePortDelivery {
  double? freightAmnount;
  int? freightFuelAmt;
  int? awbFee;
  String? airHandingCharges;
  int? customDocs;
  String? minHandlingIn;
  String? minHandlingOut;
  int? transportToApt;
  int? portDeliveryTt;
  double? totalAmount;
  double? marginAmount;
  int? subTotal;
  AdditionalCharges? additionalCharges;
  int? totalAdditionalCharges;
  String? totalDutyTax;
  int? portGrantTotal;

  PurplePortDelivery({
    this.freightAmnount,
    this.freightFuelAmt,
    this.awbFee,
    this.airHandingCharges,
    this.customDocs,
    this.minHandlingIn,
    this.minHandlingOut,
    this.transportToApt,
    this.portDeliveryTt,
    this.totalAmount,
    this.marginAmount,
    this.subTotal,
    this.additionalCharges,
    this.totalAdditionalCharges,
    this.totalDutyTax,
    this.portGrantTotal,
  });

  factory PurplePortDelivery.fromRawJson(String str) => PurplePortDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurplePortDelivery.fromJson(Map<String, dynamic> json) => PurplePortDelivery(
    freightAmnount: json["freight_amnount"]?.toDouble(),
    freightFuelAmt: json["freight_fuel_amt"],
    awbFee: json["awb_fee"],
    airHandingCharges: json["air_handing_charges"],
    customDocs: json["custom_docs"],
    minHandlingIn: json["min_handling_in"],
    minHandlingOut: json["min_handling_out"],
    transportToApt: json["transport_to_apt"],
    portDeliveryTt: json["port_delivery_tt"],
    totalAmount: json["total_amount"]?.toDouble(),
    marginAmount: json["margin_amount"]?.toDouble(),
    subTotal: json["sub_total"],
    additionalCharges: json["additional_charges"] == null ? null : AdditionalCharges.fromJson(json["additional_charges"]),
    totalAdditionalCharges: json["total_additional_charges"],
    totalDutyTax: json["total_duty_tax"],
    portGrantTotal: json["port_grant_total"],
  );

  Map<String, dynamic> toJson() => {
    "freight_amnount": freightAmnount,
    "freight_fuel_amt": freightFuelAmt,
    "awb_fee": awbFee,
    "air_handing_charges": airHandingCharges,
    "custom_docs": customDocs,
    "min_handling_in": minHandlingIn,
    "min_handling_out": minHandlingOut,
    "transport_to_apt": transportToApt,
    "port_delivery_tt": portDeliveryTt,
    "total_amount": totalAmount,
    "margin_amount": marginAmount,
    "sub_total": subTotal,
    "additional_charges": additionalCharges?.toJson(),
    "total_additional_charges": totalAdditionalCharges,
    "total_duty_tax": totalDutyTax,
    "port_grant_total": portGrantTotal,
  };
}

class BreakdownsQuoteCourier {
  Map<String, double>? fedexCourier;
  Map<String, double>? dhlCourier;
  FluffyDoorDelivery? doorDelivery;

  BreakdownsQuoteCourier({
    this.fedexCourier,
    this.dhlCourier,
    this.doorDelivery,
  });

  factory BreakdownsQuoteCourier.fromRawJson(String str) => BreakdownsQuoteCourier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BreakdownsQuoteCourier.fromJson(Map<String, dynamic> json) => BreakdownsQuoteCourier(
    fedexCourier: Map.from(json["fedex_courier"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    dhlCourier: Map.from(json["dhl_courier"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    doorDelivery: json["door_delivery"] == null ? null : FluffyDoorDelivery.fromJson(json["door_delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "fedex_courier": Map.from(fedexCourier!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "dhl_courier": Map.from(dhlCourier!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "door_delivery": doorDelivery?.toJson(),
  };
}

class FluffyDoorDelivery {
  String? doorDeliveryTt;
  double? totalAmount;
  double? marginAmount;
  int? subTotal;
  AdditionalCharges? additionalCharges;
  int? totalAdditionalCharges;
  String? totalDutyTax;
  int? doorGrantTotal;

  FluffyDoorDelivery({
    this.doorDeliveryTt,
    this.totalAmount,
    this.marginAmount,
    this.subTotal,
    this.additionalCharges,
    this.totalAdditionalCharges,
    this.totalDutyTax,
    this.doorGrantTotal,
  });

  factory FluffyDoorDelivery.fromRawJson(String str) => FluffyDoorDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FluffyDoorDelivery.fromJson(Map<String, dynamic> json) => FluffyDoorDelivery(
    doorDeliveryTt: json["door_delivery_tt"],
    totalAmount: json["total_amount"]?.toDouble(),
    marginAmount: json["margin_amount"]?.toDouble(),
    subTotal: json["sub_total"],
    additionalCharges: json["additional_charges"] == null ? null : AdditionalCharges.fromJson(json["additional_charges"]),
    totalAdditionalCharges: json["total_additional_charges"],
    totalDutyTax: json["total_duty_tax"],
    doorGrantTotal: json["door_grant_total"],
  );

  Map<String, dynamic> toJson() => {
    "door_delivery_tt": doorDeliveryTt,
    "total_amount": totalAmount,
    "margin_amount": marginAmount,
    "sub_total": subTotal,
    "additional_charges": additionalCharges?.toJson(),
    "total_additional_charges": totalAdditionalCharges,
    "total_duty_tax": totalDutyTax,
    "door_grant_total": doorGrantTotal,
  };
}

class BreakdownsQuoteLand {
  TentacledDoorDelivery? doorDelivery;

  BreakdownsQuoteLand({
    this.doorDelivery,
  });

  factory BreakdownsQuoteLand.fromRawJson(String str) => BreakdownsQuoteLand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BreakdownsQuoteLand.fromJson(Map<String, dynamic> json) => BreakdownsQuoteLand(
    doorDelivery: json["door_delivery"] == null ? null : TentacledDoorDelivery.fromJson(json["door_delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "door_delivery": doorDelivery?.toJson(),
  };
}

class TentacledDoorDelivery {
  TentacledDoorDelivery();

  factory TentacledDoorDelivery.fromRawJson(String str) => TentacledDoorDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TentacledDoorDelivery.fromJson(Map<String, dynamic> json) => TentacledDoorDelivery(
  );

  Map<String, dynamic> toJson() => {
  };
}

class QuoteSea {
  FluffyPortDelivery? portDelivery;
  StickyDoorDelivery? doorDelivery;

  QuoteSea({
    this.portDelivery,
    this.doorDelivery,
  });

  factory QuoteSea.fromRawJson(String str) => QuoteSea.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuoteSea.fromJson(Map<String, dynamic> json) => QuoteSea(
    portDelivery: json["port_delivery"] == null ? null : FluffyPortDelivery.fromJson(json["port_delivery"]),
    doorDelivery: json["door_delivery"] == null ? null : StickyDoorDelivery.fromJson(json["door_delivery"]),
  );

  Map<String, dynamic> toJson() => {
    "port_delivery": portDelivery?.toJson(),
    "door_delivery": doorDelivery?.toJson(),
  };
}

class StickyDoorDelivery {
  double? freightAmnount;
  int? blFee;
  int? weightCharges;
  int? customDocs;
  int? transportToSeaPort;
  String? handlingInOut;
  int? nvoccChargesFixed;
  double? nvoccChargesPerCmb;
  int? portCharges;
  int? customsClearance;
  int? bankCharges;
  int? deliveryOrderFee;
  int? quarantineFee;
  int? transportTariff;
  int? doorDeliveryTt;
  double? totalAmount;
  double? marginAmount;
  int? subTotal;
  AdditionalCharges? additionalCharges;
  int? totalAdditionalCharges;
  String? totalDutyTax;
  int? doorGrantTotal;

  StickyDoorDelivery({
    this.freightAmnount,
    this.blFee,
    this.weightCharges,
    this.customDocs,
    this.transportToSeaPort,
    this.handlingInOut,
    this.nvoccChargesFixed,
    this.nvoccChargesPerCmb,
    this.portCharges,
    this.customsClearance,
    this.bankCharges,
    this.deliveryOrderFee,
    this.quarantineFee,
    this.transportTariff,
    this.doorDeliveryTt,
    this.totalAmount,
    this.marginAmount,
    this.subTotal,
    this.additionalCharges,
    this.totalAdditionalCharges,
    this.totalDutyTax,
    this.doorGrantTotal,
  });

  factory StickyDoorDelivery.fromRawJson(String str) => StickyDoorDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StickyDoorDelivery.fromJson(Map<String, dynamic> json) => StickyDoorDelivery(
    freightAmnount: json["freight_amnount"]?.toDouble(),
    blFee: json["bl_fee"],
    weightCharges: json["weight_charges"],
    customDocs: json["custom_docs"],
    transportToSeaPort: json["transport_to_sea_port"],
    handlingInOut: json["handling_in_out"],
    nvoccChargesFixed: json["nvocc_charges_fixed"],
    nvoccChargesPerCmb: json["nvocc_charges_per_cmb"]?.toDouble(),
    portCharges: json["port_charges"],
    customsClearance: json["customsClearance"],
    bankCharges: json["bankCharges"],
    deliveryOrderFee: json["deliveryOrderFee"],
    quarantineFee: json["quarantineFee"],
    transportTariff: json["transportTariff"],
    doorDeliveryTt: json["door_delivery_tt"],
    totalAmount: json["total_amount"]?.toDouble(),
    marginAmount: json["margin_amount"]?.toDouble(),
    subTotal: json["sub_total"],
    additionalCharges: json["additional_charges"] == null ? null : AdditionalCharges.fromJson(json["additional_charges"]),
    totalAdditionalCharges: json["total_additional_charges"],
    totalDutyTax: json["total_duty_tax"],
    doorGrantTotal: json["door_grant_total"],
  );

  Map<String, dynamic> toJson() => {
    "freight_amnount": freightAmnount,
    "bl_fee": blFee,
    "weight_charges": weightCharges,
    "custom_docs": customDocs,
    "transport_to_sea_port": transportToSeaPort,
    "handling_in_out": handlingInOut,
    "nvocc_charges_fixed": nvoccChargesFixed,
    "nvocc_charges_per_cmb": nvoccChargesPerCmb,
    "port_charges": portCharges,
    "customsClearance": customsClearance,
    "bankCharges": bankCharges,
    "deliveryOrderFee": deliveryOrderFee,
    "quarantineFee": quarantineFee,
    "transportTariff": transportTariff,
    "door_delivery_tt": doorDeliveryTt,
    "total_amount": totalAmount,
    "margin_amount": marginAmount,
    "sub_total": subTotal,
    "additional_charges": additionalCharges?.toJson(),
    "total_additional_charges": totalAdditionalCharges,
    "total_duty_tax": totalDutyTax,
    "door_grant_total": doorGrantTotal,
  };
}

class FluffyPortDelivery {
  double? freightAmnount;
  int? blFee;
  int? weightCharges;
  int? customDocs;
  int? transportToSeaPort;
  String? handlingInOut;
  int? portDeliveryTt;
  double? totalAmount;
  double? marginAmount;
  int? subTotal;
  AdditionalCharges? additionalCharges;
  int? totalAdditionalCharges;
  String? totalDutyTax;
  int? portGrantTotal;

  FluffyPortDelivery({
    this.freightAmnount,
    this.blFee,
    this.weightCharges,
    this.customDocs,
    this.transportToSeaPort,
    this.handlingInOut,
    this.portDeliveryTt,
    this.totalAmount,
    this.marginAmount,
    this.subTotal,
    this.additionalCharges,
    this.totalAdditionalCharges,
    this.totalDutyTax,
    this.portGrantTotal,
  });

  factory FluffyPortDelivery.fromRawJson(String str) => FluffyPortDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FluffyPortDelivery.fromJson(Map<String, dynamic> json) => FluffyPortDelivery(
    freightAmnount: json["freight_amnount"]?.toDouble(),
    blFee: json["bl_fee"],
    weightCharges: json["weight_charges"],
    customDocs: json["custom_docs"],
    transportToSeaPort: json["transport_to_sea_port"],
    handlingInOut: json["handling_in_out"],
    portDeliveryTt: json["port_delivery_tt"],
    totalAmount: json["total_amount"]?.toDouble(),
    marginAmount: json["margin_amount"]?.toDouble(),
    subTotal: json["sub_total"],
    additionalCharges: json["additional_charges"] == null ? null : AdditionalCharges.fromJson(json["additional_charges"]),
    totalAdditionalCharges: json["total_additional_charges"],
    totalDutyTax: json["total_duty_tax"],
    portGrantTotal: json["port_grant_total"],
  );

  Map<String, dynamic> toJson() => {
    "freight_amnount": freightAmnount,
    "bl_fee": blFee,
    "weight_charges": weightCharges,
    "custom_docs": customDocs,
    "transport_to_sea_port": transportToSeaPort,
    "handling_in_out": handlingInOut,
    "port_delivery_tt": portDeliveryTt,
    "total_amount": totalAmount,
    "margin_amount": marginAmount,
    "sub_total": subTotal,
    "additional_charges": additionalCharges?.toJson(),
    "total_additional_charges": totalAdditionalCharges,
    "total_duty_tax": totalDutyTax,
    "port_grant_total": portGrantTotal,
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
