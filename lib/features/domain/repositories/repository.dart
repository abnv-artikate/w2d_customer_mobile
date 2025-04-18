import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';

abstract class Repository {
  Future<Either<Failure, String>> sendOtp({required SendOtpParams params});

  Future<Either<Failure, UserEntity>> verifyOtp({required VerifyOtpParams params});
}
