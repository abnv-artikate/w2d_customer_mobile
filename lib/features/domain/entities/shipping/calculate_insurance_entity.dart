class CalculateInsuranceEntity {
  int code;
  bool status;
  String info;
  String message;
  CalculateInsuranceEntityData data;

  CalculateInsuranceEntity({
    required this.code,
    required this.status,
    required this.info,
    required this.message,
    required this.data,
  });

}

class CalculateInsuranceEntityData {
  int goodsValue;
  int freightAmount;
  int insuranceAmt;
  String totalDutyTax;
  int netTotal;

  CalculateInsuranceEntityData({
    required this.goodsValue,
    required this.freightAmount,
    required this.insuranceAmt,
    required this.totalDutyTax,
    required this.netTotal,
  });

}
