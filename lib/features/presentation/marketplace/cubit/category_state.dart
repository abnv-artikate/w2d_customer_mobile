part of 'category_cubit.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<ResultEntity> productCategoryListing;

  CategoryLoaded({required this.productCategoryListing});
}

final class ProductViewLoading extends CategoryState {}

final class ProductViewLoaded extends CategoryState {
  final ProductViewEntity productEntity;

  ProductViewLoaded({required this.productEntity});
}

final class CartSyncLoading extends CategoryState {}

final class CartSyncLoaded extends CategoryState {
  final String message;

  CartSyncLoaded({required this.message});
}

final class CategoryError extends CategoryState {
  final String error;

  CategoryError(this.error);
}
