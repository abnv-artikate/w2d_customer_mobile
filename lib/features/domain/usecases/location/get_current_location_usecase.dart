import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;
import 'package:location/location.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';

class GetCurrentLocationUseCase {
  Future<Either<String, LocationEntity>> call({
    LocationAccuracy accuracy = LocationAccuracy.reduced,
  }) async {
    try {
      Location location = Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      // if (!_serviceEnabled) {
      //   _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Left("Location Service disabled");
      }
      // }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return Left("Location Service disabled");
        }
      }

      _locationData = await location.getLocation();

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        _locationData.latitude!,
        _locationData.longitude!,
      );

      Placemark place = placemarks[1];

      return Right(
        LocationEntity(
          city: place.locality ?? place.subAdministrativeArea ?? "",
          country: place.country ?? "",
          isoCountryCode: place.isoCountryCode ?? "",
          latitude: _locationData.latitude?.toDouble() ?? 0.0,
          longitude: _locationData.longitude?.toDouble() ?? 0.0,
        ),
      );
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
