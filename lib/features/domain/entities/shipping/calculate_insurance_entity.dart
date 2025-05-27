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
  double? goodsValue;
  double? freightAmount;

  // to be shown in transit insurance field
  double? insuranceAmt;

  // if the response is string show string in information form if response ids double show in dest duty/tax/other fees field
  dynamic totalDutyTax;
  double? netTotal;

  CalculateInsuranceEntityData({
    required this.goodsValue,
    required this.freightAmount,
    required this.insuranceAmt,
    required this.totalDutyTax,
    required this.netTotal,
  });
}
