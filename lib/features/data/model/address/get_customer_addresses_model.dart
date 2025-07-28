import 'dart:convert';

import 'package:w2d_customer_mobile/features/domain/entities/address/customer_address_entity.dart';

class CustomerAddressesModel {
  String? status;
  List<CustomerAddressesData>? data;

  CustomerAddressesModel({this.status, this.data});

  factory CustomerAddressesModel.fromRawJson(String str) =>
      CustomerAddressesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerAddressesModel.fromJson(Map<String, dynamic> json) =>
      CustomerAddressesModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<CustomerAddressesData>.from(
                  json["data"]!.map((x) => CustomerAddressesData.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CustomerAddressesData {
  int? id;
  int? customer;
  String? addressType;
  String? fullName;
  String? primaryPhoneNumber;
  String? secondaryPhoneNumber;
  String? addressLine1;
  String? fileUrl;
  String? addressLine2;
  String? city;
  String? stateProvince;
  String? latitude;
  String? longitude;
  String? country;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  CustomerAddressesData({
    this.id,
    this.customer,
    this.addressType,
    this.fullName,
    this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    this.addressLine1,
    this.fileUrl,
    this.addressLine2,
    this.city,
    this.stateProvince,
    this.latitude,
    this.longitude,
    this.country,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerAddressesData.fromRawJson(String str) =>
      CustomerAddressesData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerAddressesData.fromJson(Map<String, dynamic> json) =>
      CustomerAddressesData(
        id: json["id"],
        customer: json["customer"],
        addressType: json["address_type"],
        fullName: json["full_name"],
        primaryPhoneNumber: json["primary_phone_number"],
        secondaryPhoneNumber: json["secondary_phone_number"],
        addressLine1: json["address_line_1"],
        fileUrl: json["file_url"],
        addressLine2: json["address_line_2"],
        city: json["city"],
        stateProvince: json["state_province"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        country: json["country"],
        isDefault: json["is_default"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "address_type": addressType,
    "full_name": fullName,
    "primary_phone_number": primaryPhoneNumber,
    "secondary_phone_number": secondaryPhoneNumber,
    "address_line_1": addressLine1,
    "file_url": fileUrl,
    "address_line_2": addressLine2,
    "city": city,
    "state_province": stateProvince,
    "latitude": latitude,
    "longitude": longitude,
    "country": country,
    "is_default": isDefault,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  CustomerAddressesEntity toEntity() => CustomerAddressesEntity(
    id: id ?? -1,
    customer: customer ?? -1,
    addressType: addressType ?? "",
    fullName: fullName ?? "",
    primaryPhoneNumber: primaryPhoneNumber ?? "",
    secondaryPhoneNumber: secondaryPhoneNumber ?? "",
    addressLine1: addressLine1 ?? "",
    fileUrl: fileUrl ?? "",
    addressLine2: addressLine2 ?? "",
    city: city ?? "",
    stateProvince: stateProvince ?? "",
    latitude: latitude ?? "",
    longitude: longitude ?? "",
    country: country ?? "",
    isDefault: isDefault ?? false,
    createdAt: createdAt ?? "",
    updatedAt: updatedAt ?? "",
  );
}
