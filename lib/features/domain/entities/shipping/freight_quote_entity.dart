class FreightQuoteEntity {
  int code;
  bool status;
  String info;
  String message;
  FreightQuoteEntityData data;

  FreightQuoteEntity({
    required this.code,
    required this.status,
    required this.info,
    required this.message,
    required this.data,
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
