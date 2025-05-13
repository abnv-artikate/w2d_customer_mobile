class ConfirmInsuranceEntity {
  int code;
  bool status;
  String info;
  String message;
  ConfirmInsuranceEntityData data;

  ConfirmInsuranceEntity({
    required this.code,
    required this.status,
    required this.info,
    required this.message,
    required this.data,
  });
}

class ConfirmInsuranceEntityData {
  int freightAmount;
  int insuranceAmt;
  String totalDutyTax;
  int netTotal;

  ConfirmInsuranceEntityData({
    required this.freightAmount,
    required this.insuranceAmt,
    required this.totalDutyTax,
    required this.netTotal,
  });
}
