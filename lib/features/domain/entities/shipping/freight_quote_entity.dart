class FreightQuoteEntity {
  int code;
  bool status;
  String info;
  String message;
  FreightQuoteEntityData data;
  FreightQuoteBreakdownsEntity breakdowns;

  FreightQuoteEntity({
    required this.code,
    required this.status,
    required this.info,
    required this.message,
    required this.data,
    required this.breakdowns,
  });

}

class FreightQuoteBreakdownsEntity {
  FreightQuoteAirEntity quoteAir;
  QuoteSeaEntity quoteSea;
  BreakdownsQuoteCourierEntity quoteCourier;
  BreakdownsQuoteLandEntity quoteLand;

  FreightQuoteBreakdownsEntity({
    required this.quoteAir,
    required this.quoteSea,
    required this.quoteCourier,
    required this.quoteLand,
  });

}

class FreightQuoteAirEntity {
  PurplePortDeliveryEntity portDelivery;
  PurpleDoorDeliveryEntity doorDelivery;

  FreightQuoteAirEntity({
    required this.portDelivery,
    required this.doorDelivery,
  });

}

class PurpleDoorDeliveryEntity {
  double freightAmount;
  int freightFuelAmt;
  int awbFee;
  String airHandingCharges;
  int customDocs;
  String minHandlingIn;
  String minHandlingOut;
  int transportToApt;
  String destinationCharges;
  double doorAirlineCharges;
  int customsClearance;
  int deliveryOrderFee;
  int doorDeliveryTt;
  double totalAmount;
  double marginAmount;
  int subTotal;
  AdditionalChargesEntity additionalCharges;
  int totalAdditionalCharges;
  String totalDutyTax;
  int doorGrantTotal;

  PurpleDoorDeliveryEntity({
    required this.freightAmount,
    required this.freightFuelAmt,
    required this.awbFee,
    required this.airHandingCharges,
    required this.customDocs,
    required this.minHandlingIn,
    required this.minHandlingOut,
    required this.transportToApt,
    required this.destinationCharges,
    required this.doorAirlineCharges,
    required this.customsClearance,
    required this.deliveryOrderFee,
    required this.doorDeliveryTt,
    required this.totalAmount,
    required this.marginAmount,
    required this.subTotal,
    required this.additionalCharges,
    required this.totalAdditionalCharges,
    required this.totalDutyTax,
    required this.doorGrantTotal,
  });

}

class AdditionalChargesEntity {
  AttrEntity attr;
  int hsAdditional;
  int overWeight;

  AdditionalChargesEntity({
    required this.attr,
    required this.hsAdditional,
    required this.overWeight,
  });

}

class AttrEntity {
  BatteryEntity battery;

  AttrEntity({
    required this.battery,
  });

}

class BatteryEntity {
  int dgDeclaration;
  int dangerousGoodsFee;
  int dgPacking;
  double airlineHandling;

  BatteryEntity({
    required this.dgDeclaration,
    required this.dangerousGoodsFee,
    required this.dgPacking,
    required this.airlineHandling,
  });

}

class PurplePortDeliveryEntity {
  double freightAmount;
  int freightFuelAmt;
  int awbFee;
  String airHandingCharges;
  int customDocs;
  String minHandlingIn;
  String minHandlingOut;
  int transportToApt;
  int portDeliveryTt;
  double totalAmount;
  double marginAmount;
  int subTotal;
  AdditionalChargesEntity additionalCharges;
  int totalAdditionalCharges;
  String totalDutyTax;
  int portGrantTotal;

  PurplePortDeliveryEntity({
    required this.freightAmount,
    required this.freightFuelAmt,
    required this.awbFee,
    required this.airHandingCharges,
    required this.customDocs,
    required this.minHandlingIn,
    required this.minHandlingOut,
    required this.transportToApt,
    required this.portDeliveryTt,
    required this.totalAmount,
    required this.marginAmount,
    required this.subTotal,
    required this.additionalCharges,
    required this.totalAdditionalCharges,
    required this.totalDutyTax,
    required this.portGrantTotal,
  });

}

class BreakdownsQuoteCourierEntity {
  Map<String, double> fedexCourier;
  Map<String, double> dhlCourier;
  FluffyDoorDeliveryEntity doorDelivery;

  BreakdownsQuoteCourierEntity({
    required this.fedexCourier,
    required this.dhlCourier,
    required this.doorDelivery,
  });

}

class FluffyDoorDeliveryEntity {
  String doorDeliveryTt;
  double totalAmount;
  double marginAmount;
  int subTotal;
  AdditionalChargesEntity additionalCharges;
  int totalAdditionalCharges;
  String totalDutyTax;
  int doorGrantTotal;

  FluffyDoorDeliveryEntity({
    required this.doorDeliveryTt,
    required this.totalAmount,
    required this.marginAmount,
    required this.subTotal,
    required this.additionalCharges,
    required this.totalAdditionalCharges,
    required this.totalDutyTax,
    required this.doorGrantTotal,
  });

}

class BreakdownsQuoteLandEntity {
  TentacledDoorDeliveryEntity doorDelivery;

  BreakdownsQuoteLandEntity({
    required this.doorDelivery,
  });

}

class TentacledDoorDeliveryEntity {
  TentacledDoorDeliveryEntity();
}

class QuoteSeaEntity {
  FluffyPortDeliveryEntity portDelivery;
  StickyDoorDeliveryEntity doorDelivery;

  QuoteSeaEntity({
    required this.portDelivery,
    required this.doorDelivery,
  });

}

class StickyDoorDeliveryEntity {
  double freightAmount;
  int blFee;
  int weightCharges;
  int customDocs;
  int transportToSeaPort;
  String handlingInOut;
  int nvoccChargesFixed;
  double nvoccChargesPerCmb;
  int portCharges;
  int customsClearance;
  int bankCharges;
  int deliveryOrderFee;
  int quarantineFee;
  int transportTariff;
  int doorDeliveryTt;
  double totalAmount;
  double marginAmount;
  int subTotal;
  AdditionalChargesEntity additionalCharges;
  int totalAdditionalCharges;
  String totalDutyTax;
  int doorGrantTotal;

  StickyDoorDeliveryEntity({
    required this.freightAmount,
    required this.blFee,
    required this.weightCharges,
    required this.customDocs,
    required this.transportToSeaPort,
    required this.handlingInOut,
    required this.nvoccChargesFixed,
    required this.nvoccChargesPerCmb,
    required this.portCharges,
    required this.customsClearance,
    required this.bankCharges,
    required this.deliveryOrderFee,
    required this.quarantineFee,
    required this.transportTariff,
    required this.doorDeliveryTt,
    required this.totalAmount,
    required this.marginAmount,
    required this.subTotal,
    required this.additionalCharges,
    required this.totalAdditionalCharges,
    required this.totalDutyTax,
    required this.doorGrantTotal,
  });

}

class FluffyPortDeliveryEntity {
  double freightAmount;
  int blFee;
  int weightCharges;
  int customDocs;
  int transportToSeaPort;
  String handlingInOut;
  int portDeliveryTt;
  double totalAmount;
  double marginAmount;
  int subTotal;
  AdditionalChargesEntity additionalCharges;
  int totalAdditionalCharges;
  String totalDutyTax;
  int portGrantTotal;

  FluffyPortDeliveryEntity({
    required this.freightAmount,
    required this.blFee,
    required this.weightCharges,
    required this.customDocs,
    required this.transportToSeaPort,
    required this.handlingInOut,
    required this.portDeliveryTt,
    required this.totalAmount,
    required this.marginAmount,
    required this.subTotal,
    required this.additionalCharges,
    required this.totalAdditionalCharges,
    required this.totalDutyTax,
    required this.portGrantTotal,
  });

}

class FreightQuoteEntityData {
  String quoteToken;
  QuoteEntity quoteAir;
  QuoteEntity quoteSea;
  DataQuoteCourierEntity quoteCourier;
  DataQuoteLandEntity quoteLand;

  FreightQuoteEntityData({
    required this.quoteToken,
    required this.quoteAir,
    required this.quoteSea,
    required this.quoteCourier,
    required this.quoteLand,
  });

}

class QuoteEntity {
  TentacledPortDeliveryEntity portDelivery;
  IndigoDoorDeliveryEntity doorDelivery;

  QuoteEntity({
    required this.portDelivery,
    required this.doorDelivery,
  });

}

class IndigoDoorDeliveryEntity {
  String message;
  int totalAmount;
  String totalDutyTax;
  int doorGrantTotal;
  int doorDeliveryTt;

  IndigoDoorDeliveryEntity({
    required this.message,
    required this.totalAmount,
    required this.totalDutyTax,
    required this.doorGrantTotal,
    required this.doorDeliveryTt,
  });

}

class TentacledPortDeliveryEntity {
  String message;
  int totalAmount;
  String totalDutyTax;
  int portGrantTotal;
  int portDeliveryTt;

  TentacledPortDeliveryEntity({
    required this.message,
    required this.totalAmount,
    required this.totalDutyTax,
    required this.portGrantTotal,
    required this.portDeliveryTt,
  });

}

class DataQuoteCourierEntity {
  IndecentDoorDeliveryEntity doorDelivery;

  DataQuoteCourierEntity({
    required this.doorDelivery,
  });

}

class IndecentDoorDeliveryEntity {
  String doorDeliveryTt;
  String message;
  int totalAmount;
  String totalDutyTax;
  int doorGrantTotal;

  IndecentDoorDeliveryEntity({
    required this.doorDeliveryTt,
    required this.message,
    required this.totalAmount,
    required this.totalDutyTax,
    required this.doorGrantTotal,
  });

}

class DataQuoteLandEntity {
  IndigoDoorDeliveryEntity doorDelivery;

  DataQuoteLandEntity({
    required this.doorDelivery,
  });

}
