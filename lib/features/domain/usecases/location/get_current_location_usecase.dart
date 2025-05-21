import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';

class GetCurrentLocationUseCase {
  Future<Either<String, LocationEntity>> call() async {
    try {
      final hasPermission = await _handlePermission();
      if (!hasPermission) {
        throw Exception('Location permission denied');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        Placemark place = placemarks[0];
      } catch (e) {
        return Left(e.toString());
      }

      return Right(
        LocationEntity(
          city: city,
          country: country,
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
