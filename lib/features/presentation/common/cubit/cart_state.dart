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
  final List<CartItemEntity> cartItems;

  CartItemLoaded({required this.cartItems});
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
