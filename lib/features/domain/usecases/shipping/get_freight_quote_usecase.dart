import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetFreightQuoteUseCase
    extends UseCase<FreightQuoteEntity, GetFreightQuoteParams> {
  final Repository repository;

  GetFreightQuoteUseCase(this.repository);

  @override
  Future<Either<Failure, FreightQuoteEntity>> call(
    GetFreightQuoteParams params,
  ) async {
    return await repository.getFreightQuote(params: params);
  }
}

class GetFreightQuoteParams {
  final String? destinationCountry;
  // final String destinationCountryShortName;
  final String? destinationCity;
  final String? destinationLatitude;
  final String? destinationLongitude;
  final String? itemsGoods;
  final List<Items?> items;

  GetFreightQuoteParams({
    required this.destinationCountry,
    // required this.destinationCountryShortName,
    required this.destinationCity,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.itemsGoods,
    required this.items,
  });
}

class Items {
  final String itemDescription;
  final int noOfPkgs;
  final String attribute;
  final String hsCode;
  final List<Dimensions> dimensions;

  Items({
    required this.itemDescription,
    required this.noOfPkgs,
    required this.attribute,
    required this.hsCode,
    required this.dimensions,
  });
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
