import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class VerifyPaymentUseCase extends UseCase<String, String> {
  final Repository _repository;

  VerifyPaymentUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(String transCode) {
    return _repository.verifyPayment(transCode);
  }
}
