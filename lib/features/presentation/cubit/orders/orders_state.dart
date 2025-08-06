part of 'orders_cubit.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrderPendingLoading extends OrdersState {}

final class OrderPendingLoaded extends OrdersState {
  final String startUrl;
  final String transactionCode;

  OrderPendingLoaded({required this.startUrl, required this.transactionCode});
}

final class OrderPendingError extends OrdersState {
  final String error;

  OrderPendingError({required this.error});
}

final class OrderSuccessLoading extends OrdersState {}

final class OrderSuccessLoaded extends OrdersState {}

final class OrderSuccessError extends OrdersState {
  final String error;

  OrderSuccessError({required this.error});
}

final class GetOrdersLoading extends OrdersState {}

final class GetOrdersLoaded extends OrdersState {
  final OrderListEntity orderList;

  GetOrdersLoaded({required this.orderList});
}

final class GetOrdersError extends OrdersState {
  final String error;

  GetOrdersError({required this.error});
}

final class GetOrdersByIdLoading extends OrdersState {}

final class GetOrdersByIdLoaded extends OrdersState {}

final class GetOrdersByIdError extends OrdersState {
  final String error;

  GetOrdersByIdError({required this.error});
}
