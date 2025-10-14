class VouchersEntity {
  final String code;
  final String title;
  final String description;
  final String discountType;
  final int discountValue;
  final double minSpent;

  VouchersEntity({
    required this.code,
    required this.title,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.minSpent,
  });
}
