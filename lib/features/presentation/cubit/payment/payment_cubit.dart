import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/confirm_payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_request_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/telr_payment/payment_response_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/payment/initiate_payment_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/payment/verify_payment_usecase.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required this.initiatePaymentUseCase,
    required this.verifyPaymentUseCase,
    required this.localDatasource,
  }) : super(PaymentInitial());
  final InitiatePaymentUseCase initiatePaymentUseCase;
  final VerifyPaymentUseCase verifyPaymentUseCase;
  final LocalDatasource localDatasource;

  initiatePayment({
    required String cartId,
    required String amount,
    required String firstName,
    required String street,
    required String city,
    required String country,
    String zip = "",
    required String phone,
  }) async {
    emit(InitiatePaymentLoading());

    final result = await initiatePaymentUseCase.call(
      PaymentRequestEntity(
        storeId: localDatasource.getStoreID() ?? "",
        authKey: localDatasource.getStoreAuthKey() ?? "",
        cartId: cartId,
        amount: amount,
        currency: "AED",
        firstName: firstName,
        lastName: "",
        street: street,
        city: city,
        region: "",
        country: country,
        zip: zip,
        email: localDatasource.getUserEmail() ?? "",
        phone: phone,
      ),
    );

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
        emit(VerifyPaymentLoaded(response: r, paymentRef: transCode));
      },
    );
  }
}
