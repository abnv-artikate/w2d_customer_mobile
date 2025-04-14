import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class SendOtpUseCase extends UseCase<String, SendOtpParams> {
  final Repository _repository;

  SendOtpUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(SendOtpParams params) async {
    return await _repository.sendOtp(params: params);
  }
}

class SendOtpParams {
  String email;
  String? fullName;
  String type;

  SendOtpParams({required this.email, required this.type, this.fullName});
}

// enum TypeEnum {
//   existing,
//   new
// }
