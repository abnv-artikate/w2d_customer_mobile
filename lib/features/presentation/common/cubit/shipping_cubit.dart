import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';

part 'shipping_state.dart';

class ShippingCubit extends Cubit<ShippingState> {
  ShippingCubit({required this.getFreightQuoteUseCase})
    : super(ShippingInitial());

  final GetFreightQuoteUseCase getFreightQuoteUseCase;

  getFreightQuote(GetFreightQuoteParams params) async {
    final result = await getFreightQuoteUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(ShippingLoaded(freightQuoteEntity: data));
    });
  }

  FutureOr<void> _emitFailure(Failure failure) async {
    if (failure is ServerFailure) {
      emit(ShippingError(failure.message));
    } else if (failure is CacheFailure) {
      emit(ShippingError(failure.message));
    } else {
      emit(ShippingError(failure.message));
    }
  }
}
