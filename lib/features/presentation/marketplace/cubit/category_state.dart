part of 'category_cubit.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<ProductCategoryListingEntity> productCategoryListing;

  CategoryLoaded({required this.productCategoryListing});
}

final class ProductViewLoading extends CategoryState {}

final class ProductViewLoaded extends CategoryState {
  final ProductViewEntity productEntity;

  ProductViewLoaded({required this.productEntity});
}

final class CategoryError extends CategoryState {
  final String error;

  CategoryError(this.error);
}
