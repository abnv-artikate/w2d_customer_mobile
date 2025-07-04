import 'package:dartz/dartz.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/repositories/repository.dart';

class InitiatePaymentUseCase extends UseCase<PaymentResponseEntity, PaymentRequestEntity> {
  final Repository repository;

  InitiatePaymentUseCase(this.repository);
  @override
  Future<Either<Failure, PaymentResponseEntity>> call(PaymentRequestEntity request) {
    return repository.initiatePayment(request);
  }
}