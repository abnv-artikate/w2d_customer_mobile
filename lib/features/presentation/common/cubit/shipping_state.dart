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

final class ShippingError extends ShippingState {
  final String message;

  ShippingError(this.message);
}
