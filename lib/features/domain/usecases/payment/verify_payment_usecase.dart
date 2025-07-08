import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/confirm_payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class VerifyPaymentUseCase extends UseCase<ConfirmPaymentResponseEntity, String> {
  final Repository _repository;

  VerifyPaymentUseCase(this._repository);

  @override
  Future<Either<Failure, ConfirmPaymentResponseEntity>> call(String transCode) {
    return _repository.verifyPayment(transCode);
  }
}
