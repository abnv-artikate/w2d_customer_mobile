import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/exceptions.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/network/network_info.dart';
import 'package:w2d_customer_mobile/core/utils/constants.dart';
import 'package:w2d_customer_mobile/features/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';

class RepositoryImpl extends Repository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  RepositoryImpl({required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> sendOtp({
    required SendOtpParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.sendOtp(
          queries: {"type": params.type},
          body: {"email": params.email},
        );

        return Right(result.message ?? 'OTP sent successfully');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required VerifyOtpParams params,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.verifyOtp({
          "email": params.email,
          "otp": params.otp,
        });

        return Right(result.message ?? "Logins success");
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
