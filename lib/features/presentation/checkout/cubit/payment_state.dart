part of 'payment_cubit.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class InitiatePaymentLoading extends PaymentState {}

final class InitiatePaymentLoaded extends PaymentState {
  final PaymentResponseEntity response;

  InitiatePaymentLoaded({required this.response});
}

final class InitiatePaymentError extends PaymentState {
  final String error;

  InitiatePaymentError({required this.error});
}

final class VerifyPaymentLoading extends PaymentState {}

final class VerifyPaymentLoaded extends PaymentState {
  final String message;

  VerifyPaymentLoaded({required this.message});
}

final class VerifyPaymentError extends PaymentState {
  final String error;

  VerifyPaymentError({required this.error});
}
