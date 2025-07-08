part of 'orders_cubit.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class CreateOrderLoading extends OrdersState {}

final class CreateOrderLoaded extends OrdersState {}

final class CreateOrderError extends OrdersState {}
