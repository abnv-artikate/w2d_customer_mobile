class CustomerAddressesEntity {
  final int id;
  final int customer;
  final String addressType;
  final String fullName;
  final String primaryPhoneNumber;
  final String secondaryPhoneNumber;
  final String addressLine1;
  final String fileUrl;
  final String addressLine2;
  final String city;
  final String stateProvince;
  final String latitude;
  final String longitude;
  final String country;
  final bool isDefault;
  final String createdAt;
  final String updatedAt;

  CustomerAddressesEntity({
    required this.id,
    required this.customer,
    required this.addressType,
    required this.fullName,
    required this.primaryPhoneNumber,
    required this.secondaryPhoneNumber,
    required this.addressLine1,
    required this.fileUrl,
    required this.addressLine2,
    required this.city,
    required this.stateProvince,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });
}
