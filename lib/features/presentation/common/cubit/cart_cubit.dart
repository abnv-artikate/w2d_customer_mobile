import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/get_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_current_location_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.cartSyncUseCase,
    required this.getCartItemUseCase,
    required this.getCurrentLocationUseCase,
  }) : super(CartInitial());

  final CartSyncUseCase cartSyncUseCase;
  final GetCartUseCase getCartItemUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  cartSync({required CartSyncParams params}) async {
    emit(CartSyncLoading());
    final result = await cartSyncUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(CartSyncLoaded(message: data));
    });
  }

  getCartItems() async {
    emit(CartItemLoading());

    final result = await getCartItemUseCase.call(NoParams());

    result.fold((l) => _emitFailure(l), (data) {
      emit(CartItemLoaded(cartItems: data.items));
    });
  }

  FutureOr<void> _emitFailure(Failure failure) async {
    if (failure is ServerFailure) {
      emit(CartError(failure.message));
    } else if (failure is CacheFailure) {
      emit(CartError(failure.message));
    } else {
      emit(CartError(failure.message));
    }
  }
}
