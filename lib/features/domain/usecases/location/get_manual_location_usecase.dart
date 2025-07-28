import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';

class GetManualLocationUseCase {
  Future<Either<String, LocationEntity>> call(GetManualLocationParams params) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        params.latitude,
        params.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return Right(
          LocationEntity(
            city: place.locality ?? place.subAdministrativeArea ?? "",
            country: place.country ?? "",
            isoCountryCode: place.isoCountryCode ?? "",
            latitude: params.latitude,
            longitude: params.longitude,
          ),
        );
      }
      return Left("Unable to get location from address");
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class GetManualLocationParams {
  final double latitude;
  final double longitude;

  GetManualLocationParams({required this.latitude, required this.longitude});
}
