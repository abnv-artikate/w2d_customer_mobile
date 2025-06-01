import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';

class GetCurrentLocationUseCase {
  // static const Duration _timeoutDuration = Duration(seconds: 10);

  Future<Either<String, LocationEntity>> call({
    LocationAccuracy accuracy = LocationAccuracy.medium,
    Duration? timeout,
  }) async {
    try {
      final hasPermission = await _handlePermission();
      if (!hasPermission) {
        return const Left('Location permission denied');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: accuracy,
          distanceFilter: 10,
        ),
      );

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      return Right(
        LocationEntity(
          city: place.locality ?? place.subAdministrativeArea ?? "",
          country: place.country ?? "",
          isoCountryCode: place.isoCountryCode ?? "",
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
        ),
      );
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<bool> _handlePermission() async {
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return false;
    // }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
