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

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      // if (!_serviceEnabled) {
      //   _serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Left("Location Service disabled");
      }
      // }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return Left("Location Service disabled");
        }
      }

      locationData = await location.getLocation();

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      Placemark place = placemarks[1];

      return Right(
        LocationEntity(
          city: place.locality ?? place.subAdministrativeArea ?? "",
          country: place.country ?? "",
          isoCountryCode: place.isoCountryCode ?? "",
          latitude: locationData.latitude?.toDouble() ?? 0.0,
          longitude: locationData.longitude?.toDouble() ?? 0.0,
        ),
      );
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
