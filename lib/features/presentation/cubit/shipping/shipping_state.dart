part of 'shipping_cubit.dart';

sealed class ShippingState {}

final class ShippingInitial extends ShippingState {}

final class GetFreightQuoteLoading extends ShippingState {}

final class GetFreightQuoteLoaded extends ShippingState {
  final FreightQuoteEntity freightQuoteEntity;

  GetFreightQuoteLoaded({required this.freightQuoteEntity});
}

final class SelectFreightQuoteLoading extends ShippingState {}

final class SelectFreightQuoteLoaded extends ShippingState {
  final String message;

  SelectFreightQuoteLoaded({required this.message});
}

final class CalculateInsuranceLoading extends ShippingState {}

final class CalculateInsuranceLoaded extends ShippingState {
  final CalculateInsuranceEntity insuranceEntity;

  CalculateInsuranceLoaded({required this.insuranceEntity});
}

final class ConfirmInsuranceLoading extends ShippingState {}

final class ConfirmInsuranceLoaded extends ShippingState {
  final String message;

  ConfirmInsuranceLoaded({required this.message});
}

final class ShippingError extends ShippingState {
  final String error;

  ShippingError(this.error);
}
