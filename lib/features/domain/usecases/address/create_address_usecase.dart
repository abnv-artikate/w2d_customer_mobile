import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class CreateAddressUseCase extends UseCase<String, CreateAddressParams> {
  final Repository _repository;

  CreateAddressUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(CreateAddressParams params) {
    return _repository.createAddress(params);
  }
}

class CreateAddressParams {
  final String fullName;
  final String primaryPhone;
  final String secondaryPhone;
  final String addLine1;
  final String addLine2;
  final String city;
  final String latitude;
  final String longitude;
  final String country;
  final bool isDefault;

  CreateAddressParams({
    required this.fullName,
    required this.primaryPhone,
    required this.secondaryPhone,
    required this.addLine1,
    required this.addLine2,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "primary_phone_number": primaryPhone,
      "secondary_phone_number": secondaryPhone,
      "address_line_1": addLine1,
      "address_line_2": addLine2,
      "city": city,
      "latitude": latitude,
      "longitude": longitude,
      "country": country,
      "is_default": isDefault,
    };
  }
}

// {
// "full_name": "Obi Wan",
// "primary_phone_number": "9898989899",
// "secondary_phone_number": "",
// "address_line_1": "st1",
// "address_line_2": "",
// "city": "Paric",
// "latitude": "",
// "longitude": "",
// "country": "France",
// "is_default": true
// }
