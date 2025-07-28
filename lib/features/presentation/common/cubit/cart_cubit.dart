import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/core/usecase/usecase.dart';
import 'package:w2d_customer_mobile/features/domain/entities/cart/cart_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/location_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/cart_sync_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/get_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/cart/update_cart_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_current_location_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/location/get_manual_location_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.cartSyncUseCase,
    required this.getCartItemUseCase,
    required this.getCurrentLocationUseCase,
    required this.getManualLocationUseCase,
    required this.updateCartUseCase,
  }) : super(CartInitial());

  final CartSyncUseCase cartSyncUseCase;
  final GetCartUseCase getCartItemUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final GetManualLocationUseCase getManualLocationUseCase;
  final UpdateCartUseCase updateCartUseCase;

  getCurrentLocation() async {
    emit(GetLocationLoading());
    final result = await getCurrentLocationUseCase.call();

    result.fold(
      (err) {
        emit(GetLocationError(error: err));
      },
      (data) {
        emit(GetLocationLoaded(location: data));
      },
    );
  }

  getManualLocation(GetManualLocationParams params) async {
    emit(GetLocationLoading());
    final result = await getManualLocationUseCase.call(params);

    result.fold(
      (l) {
        emit(GetLocationError(error: l));
      },
      (data) {
        emit(GetManualLocationLoaded(location: data));
      },
    );
  }

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
      emit(CartItemLoaded(cart: data));
    });
  }

  updateCart(UpdateCartParams params) async {
    // emit(UpdateCartLoading());

    final result = await updateCartUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(UpdateCartLoaded(message: data.message));
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
