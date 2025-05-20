import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class GetCurrentLocationUseCase {
  final Repository repository;

  GetCurrentLocationUseCase(this.repository);

  Future<Either<String, Position>> call() async {
    try {
      final hasPermission = await _handlePermission();
      if (!hasPermission) {
        throw Exception('Location permission denied');
      }

      final position = await Geolocator.getCurrentPosition();

      return Right(position);
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
