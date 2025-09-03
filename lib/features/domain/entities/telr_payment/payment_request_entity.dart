class PaymentRequestEntity {
  final String storeId;
  final String authKey;
  final String cartId;
  final String amount;
  final String currency;
  final String firstName;
  final String lastName;
  final String street;
  final String city;
  final String region;
  final String country;
  final String zip;
  final String email;
  final String phone;

  PaymentRequestEntity({
    required this.storeId,
    required this.authKey,
    required this.cartId,
    required this.amount,
    required this.currency,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.city,
    required this.region,
    required this.country,
    required this.zip,
    required this.email,
    required this.phone,
  });
}
