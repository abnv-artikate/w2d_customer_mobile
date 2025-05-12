class SelectFreightQuoteEntity {
  int code;
  bool status;
  String info;
  String message;
  SelectFreightQuoteEntityData data;

  SelectFreightQuoteEntity({
    required this.code,
    required this.status,
    required this.info,
    required this.message,
    required this.data,
  });
}

class SelectFreightQuoteEntityData {
  int amount;

  SelectFreightQuoteEntityData({required this.amount});
}
