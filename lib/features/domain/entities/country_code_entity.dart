class CountryDetailEntity {
  final String countryName;
  final String countryCode;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;

  CountryDetailEntity({
    required this.countryName,
    required this.countryCode,
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
  });

  factory CountryDetailEntity.fromJson(Map<String, dynamic> json) {
    return CountryDetailEntity(
      countryName: json['name'],
      countryCode: json['code'],
      currencyCode: json['currency_code'],
      currencyName: json['currency_name'],
      currencySymbol: json['currency_symbol'],
    );
  }
}

// {
// "name": "United Arab Emirates",
// "code": "AE",
// "currency_code": "AED",
// "currency_name": "UAE Dirham",
// "currency_symbol": "د.إ",
// "conversion_to_aed": 1.00
// },
