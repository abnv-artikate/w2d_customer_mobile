import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class VerifyOtpUseCase extends UseCase<UserEntity, VerifyOtpParams> {
  final Repository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(VerifyOtpParams params) async {
    return await _repository.verifyOtp(params: params);
  }
}

class VerifyOtpParams {
  String email;
  String otp;

  VerifyOtpParams({required this.email, required this.otp});
}
