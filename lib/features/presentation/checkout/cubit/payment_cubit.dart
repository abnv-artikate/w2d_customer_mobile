import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/payment/initiate_payment_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/payment/verify_payment_usecase.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required this.initiatePaymentUseCase,
    required this.verifyPaymentUseCase,
  }) : super(PaymentInitial());
  final InitiatePaymentUseCase initiatePaymentUseCase;
  final VerifyPaymentUseCase verifyPaymentUseCase;

  initiatePayment(PaymentRequestEntity request) async {
    emit(InitiatePaymentLoading());

    final result = await initiatePaymentUseCase.call(request);

    result.fold(
      (l) {
        emit(InitiatePaymentError(error: l.message));
      },
      (res) {
        emit(InitiatePaymentLoaded(response: res));
      },
    );
  }

  void verifyPayment(String transCode) async {
    emit(VerifyPaymentLoading());
    final result = await verifyPaymentUseCase.call(transCode);

    result.fold(
      (l) {
        emit(VerifyPaymentError(error: l.message));
      },
      (r) {
        emit(VerifyPaymentLoaded(message: r));
      },
    );
  }
}
