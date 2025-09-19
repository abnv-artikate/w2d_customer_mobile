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

final class AddWishListLoading extends CategoryState {}

final class AddWishListLoaded extends CategoryState {
  final String message;

  AddWishListLoaded({required this.message});
}

final class AddWishListError extends CategoryState {
  final String error;

  AddWishListError({required this.error});
}

final class GetWishListLoading extends CategoryState {}

final class GetWishListLoaded extends CategoryState {
  final WishListEntity wishListEntity;

  GetWishListLoaded({required this.wishListEntity});
}

final class GetWishListError extends CategoryState {
  final String error;

  GetWishListError({required this.error});
}

final class DeleteWishListLoading extends CategoryState {}

final class DeleteWishListLoaded extends CategoryState {
  final String message;

  DeleteWishListLoaded({required this.message});
}

final class DeleteWishListError extends CategoryState {
  final String error;

  DeleteWishListError({required this.error});
}

final class RecommendationsLoading extends CategoryState {}

final class RecommendationsLoaded extends CategoryState {
  final RecommendationsEntity recommendationsEntity;

  RecommendationsLoaded({required this.recommendationsEntity});
}

final class RecommendationsError extends CategoryState {
  final String error;

  RecommendationsError({required this.error});
}

final class RelatedProductsLoading extends CategoryState {}

final class RelatedProductsLoaded extends CategoryState {
  final RelatedProductsEntity relatedProductsEntity;

  RelatedProductsLoaded({required this.relatedProductsEntity});
}

final class RelatedProductsError extends CategoryState {
  final String error;

  RelatedProductsError({required this.error});
}
