part of 'shipping_cubit.dart';

sealed class ShippingState {}

final class ShippingInitial extends ShippingState {}

final class ShippingLoading extends ShippingState {}

final class ShippingLoaded extends ShippingState {
  final FreightQuoteEntity freightQuoteEntity;

  ShippingLoaded({required this.freightQuoteEntity});
}

final class ShippingError extends ShippingState {
  final String message;

  ShippingError(this.message);
}
