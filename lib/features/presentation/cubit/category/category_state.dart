part of 'category_cubit.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryProductEntity> brandMallProductCategoryListing;
  final List<CategoryProductEntity> hiddenGemsProductCategoryListing;

  CategoryLoaded({
    required this.brandMallProductCategoryListing,
    required this.hiddenGemsProductCategoryListing,
  });
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

final class BrandToggle extends CategoryState {
  final bool isBrandMall;

  BrandToggle({required this.isBrandMall});
}
