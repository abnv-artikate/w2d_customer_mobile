class PaymentResponseEntity {
  final String startUrl;
  final String closeUrl;
  final String abortUrl;
  final String transactionCode;

  PaymentResponseEntity({
    required this.startUrl,
    required this.closeUrl,
    required this.abortUrl,
    required this.transactionCode,
  });
}
