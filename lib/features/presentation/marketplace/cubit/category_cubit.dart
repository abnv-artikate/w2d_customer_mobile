import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/features/domain/entities/categories/product_category_listing_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/product/product_view_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/categories/product_category_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/product/product_view_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required this.productViewUseCase,
    required this.productCategoryUseCase,
  }) : super(CategoryInitial());

  final ProductCategoryUseCase productCategoryUseCase;
  final ProductViewUseCase productViewUseCase;

  getProductCategoryList(ProductCategoryParams params) async {
    emit(CategoryLoading());
    final result = await productCategoryUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(CategoryLoaded(productCategoryListing: data));
    });
  }

  getProductView(ProductViewParams params) async {
    emit(ProductViewLoading());
    final result = await productViewUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(ProductViewLoaded(productEntity: data));
    });
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
