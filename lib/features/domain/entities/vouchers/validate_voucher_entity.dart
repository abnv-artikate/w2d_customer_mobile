class ValidateVoucherEntity {
  final String message;
  final String voucherType;
  final String code;
  final String name;
  final String discountType;
  final double discountValue;
  final String currency;

  ValidateVoucherEntity({
    required this.message,
    required this.voucherType,
    required this.code,
    required this.name,
    required this.discountType,
    required this.discountValue,
    required this.currency,
  });
}
