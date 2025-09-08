import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/wishlist/wishlist_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/get_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/wishlist/add_wishlist_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/wishlist/delete_wishlist_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/wishlist/get_wishlist_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required this.productViewUseCase,
    required this.productCategoryUseCase,
    required this.cartSyncUseCase,
    required this.getCartUseCase,
    required this.addWishListUseCase,
    required this.getWishListUseCase,
    required this.deleteWishListUseCase,
    required this.localDatasource,
  }) : super(CategoryInitial());

  final ProductCategoryUseCase productCategoryUseCase;
  final ProductViewUseCase productViewUseCase;
  final CartSyncUseCase cartSyncUseCase;
  final GetCartUseCase getCartUseCase;
  final AddWishListUseCase addWishListUseCase;
  final GetWishListUseCase getWishListUseCase;
  final DeleteWishListUseCase deleteWishListUseCase;
  final LocalDatasource localDatasource;

  bool get isBrand => localDatasource.getBrandMall() ?? false;

  void toggleBrand() {
    final updated = !isBrand;
    localDatasource.setBrandMall(updated);
    emit(BrandToggle(isBrandMall: updated));
  }

  getProductCategoryList(ProductCategoryParams params) async {
    emit(CategoryLoading());
    List<CategoryProductEntity> hidden = [];
    List<CategoryProductEntity> brand = [];
    final result = await productCategoryUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      for (CategoryProductEntity item in data.results) {
        if (item.seller.isHiddenGem) {
          hidden.add(item);
        } else {
          brand.add(item);
        }
      }
      emit(
        CategoryLoaded(
          brandMallProductCategoryListing: brand,
          hiddenGemsProductCategoryListing: hidden,
        ),
      );
    });
  }

  getProductView(ProductViewParams params) async {
    emit(ProductViewLoading());
    final result = await productViewUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(ProductViewLoaded(productEntity: data));
    });
  }

  cartSync(CartSyncParams params) async {
    emit(CartSyncLoading());
    final result = await cartSyncUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(CartSyncLoaded(message: data));
    });
  }

  addWishList(AddWishListParams params) async {
    emit(AddWishListLoading());
    final result = await addWishListUseCase.call(params);

    result.fold(
      (l) {
        emit(AddWishListError(error: l.message));
      },
      (r) {
        emit(AddWishListLoaded(message: r));
      },
    );
  }

  getWishList() async {
    emit(GetWishListLoading());

    final result = await getWishListUseCase.call(NoParams());

    result.fold(
      (l) {
        emit(GetWishListError(error: l.message));
      },
      (r) {
        GetWishListLoaded(wishListEntity: r);
      },
    );
  }

  deleteWishList(String id) async {
    emit(DeleteWishListLoading());

    final result = await deleteWishListUseCase.call(id);

    result.fold(
      (l) {
        emit(DeleteWishListError(error: l.message));
      },
      (r) {
        DeleteWishListLoaded(message: r);
      },
    );
  }

  FutureOr<void> _emitFailure(Failure failure) async {
    if (failure is ServerFailure) {
      emit(CategoryError(failure.message));
    } else if (failure is CacheFailure) {
      emit(CategoryError(failure.message));
    } else {
      emit(CategoryError(failure.message));
    }
  }
}
