part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartSyncLoading extends CartState {}

final class CartSyncLoaded extends CartState {
  final String message;

  CartSyncLoaded({required this.message});
}

final class CartItemLoading extends CartState {}

final class CartItemLoaded extends CartState {
  final CartEntity? cart;

  CartItemLoaded({required this.cart});
}

final class UpdateCartLoading extends CartState {}

final class UpdateCartLoaded extends CartState {
  final String message;

  UpdateCartLoaded({required this.message});
}

final class CartError extends CartState {
  final String error;

  CartError(this.error);
}

final class GetLocationLoading extends CartState {}

final class GetLocationLoaded extends CartState {
  final LocationEntity location;

  GetLocationLoaded({required this.location});
}

final class GetManualLocationLoaded extends CartState {
  final LocationEntity location;

  GetManualLocationLoaded({required this.location});
}

final class GetLocationError extends CartState {
  final String error;

  GetLocationError({required this.error});
}
