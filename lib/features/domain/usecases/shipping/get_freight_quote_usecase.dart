import "dart:convert";

import "package:dartz/dartz.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:w2d_customer_mobile/core/error/failure.dart";
import "package:w2d_customer_mobile/core/usecase/usecase.dart";
import "package:w2d_customer_mobile/features/domain/entities/country_code_entity.dart";
import "package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart";
import "package:w2d_customer_mobile/features/domain/repositories/repository.dart";
import "package:w2d_customer_mobile/generated/assets.dart";

class GetFreightQuoteUseCase
    extends UseCase<FreightQuoteEntity, GetFreightQuoteParams> {
  final Repository repository;

  GetFreightQuoteUseCase({required this.repository});

  @override
  Future<Either<Failure, FreightQuoteEntity>> call(
    GetFreightQuoteParams params,
  ) async {
    return await repository.getFreightQuote(params: await params.toJson());
  }
}

class GetFreightQuoteParams {
  final String destinationCountry;
  final String? destinationCity;
  final String? destinationLatitude;
  final String? destinationLongitude;
  final List<Items?> items;

  GetFreightQuoteParams({
    required this.destinationCountry,
    required this.destinationCity,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.items,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      "user_details": {"user_email": "christine.rozario@world2door.com"},
      "quote_by": "MARKETPLACE",
      "quote_by_email": "christine.rozario@world2door.com",
      "origin_country": "United Arab Emirates",
      "origin_country_short_name": "AE",
      "origin_city": "Dubai",
      "origin_latitude": 25.2048493,
      "origin_longitude": 55.2707828,
      "destinationCountry": destinationCountry,
      "destination_country_short_name": await getCountryShortName(
        destinationCountry,
      ),
      "destinationCity": destinationCity,
      "destinationLatitude": destinationLatitude,
      "destinationLongitude": destinationLongitude,
      "items": items.map((item) => item?.toJson()).toList(),
    };
  }

  Future<String> getCountryShortName(String destinationCountry) async {
    final List<CountryDetailEntity> countryDetails =
        await fetchCountryShortNames();
    for (CountryDetailEntity entity in countryDetails) {
      if (entity.countryName == destinationCountry) {
        return entity.countryCode;
      }
    }

    return "";
  }

  Future<List<CountryDetailEntity>> fetchCountryShortNames() async {
    try {
      final jsonString = await rootBundle.loadString(Assets.assetsCountryCodes);

      final List<dynamic> jsonData = json.decode(jsonString);

      return jsonData
          .map((json) => CountryDetailEntity.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error loading json file: ${e.toString()}");
      return [];
    }
  }
}

class Items {
  final String itemDescription;
  final int noOfPkgs;
  final String attribute;
  final String hsCode;
  final String itemsGoods;

  final List<Dimensions> dimensions;

  Items({
    required this.itemDescription,
    required this.noOfPkgs,
    required this.attribute,
    required this.hsCode,
    required this.itemsGoods,
    required this.dimensions,
  });

  Map<String, dynamic> toJson() {
    return {
      "itemDescription": itemDescription,
      "noOfPkgs": noOfPkgs,
      "attribute": attribute,
      "hsCode": hsCode,
      "item_goods": itemsGoods,
      "dimensions": dimensions.map((dimension) => dimension.toJson()).toList(),
    };
  }
}

class Dimensions {
  final double kiloGrams;
  final double length;
  final double width;
  final double height;
  final bool addWoodenPacking;

  Dimensions({
    required this.kiloGrams,
    required this.length,
    required this.width,
    required this.height,
    required this.addWoodenPacking,
  });

  Map<String, dynamic> toJson() {
    return {
      "kiloGrams": kiloGrams,
      "length": length,
      "width": width,
      "height": height,
      "addWoodenPacking": addWoodenPacking,
    };
  }
}

// {
//   "user_details": {
//     "user_email": "christine.rozario@world2doorcom"
//   },
//   "quote_by": "MARKETPLACE",
//   "quote_by_email": "christine.rozario@world2door.com",
//   "origin_country": "United Arab Emirates",
//   "origin_country_short_name": "AE",
//   "origin_city": "Dubai",
//   "origin_latitude": 25.2048493,
//   "origin_longitude": 55.2707828,
//   "destination_country": "India",
//   "destination_country_short_name": "IN",
//   "destination_city": "Mumbai",
//   "destination_latitude": 19.0759837,
//   "destination_longitude": 72.8776559,
//   "items_goods": 2500,
//   "items": [
//     {
//       "item_description": "tv1",
//       "no_of_pkgs": 1,
//       "attribute": "battery",
//       "hs_code": "123456",
//       "dimension": [
//         {
//           "kilogram": 100,
//           "length": 100,
//           "width": 100,
//           "height": 100,
//           "add_wooden_packing": true
//         }
//       ]
//     }
//   ]
// }
