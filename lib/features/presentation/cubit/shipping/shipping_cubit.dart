import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/calculate_insurance_entity.dart';
import 'package:w2d_customer_mobile/features/domain/entities/shipping/freight_quote_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/calculate_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/confirm_insurance_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/get_freight_quote_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/shipping/select_freight_service_usecase.dart';

part 'shipping_state.dart';

class ShippingCubit extends Cubit<ShippingState> {
  ShippingCubit({
    required this.getFreightQuoteUseCase,
    required this.selectFreightServiceUseCase,
    required this.calculateInsuranceUseCase,
    required this.confirmInsuranceUseCase,
  }) : super(ShippingInitial());

  final GetFreightQuoteUseCase getFreightQuoteUseCase;
  final SelectFreightServiceUseCase selectFreightServiceUseCase;
  final CalculateInsuranceUseCase calculateInsuranceUseCase;
  final ConfirmInsuranceUseCase confirmInsuranceUseCase;

  getFreightQuote({required GetFreightQuoteParams params, required }) async {
    emit(GetFreightQuoteLoading());
    final result = await getFreightQuoteUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(GetFreightQuoteLoaded(freightQuoteEntity: data));
    });
  }

  selectFreightService(SelectFreightServiceParams params) async {
    emit(SelectFreightQuoteLoading());
    final result = await selectFreightServiceUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(SelectFreightQuoteLoaded(message: data.message));
    });
  }

  calculateInsurance(CalculateInsuranceParams params) async {
    emit(CalculateInsuranceLoading());
    final result = await calculateInsuranceUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(CalculateInsuranceLoaded(insuranceEntity: data));
    });
  }

  confirmInsurance(ConfirmInsuranceParams params) async {
    emit(ConfirmInsuranceLoading());
    final result = await confirmInsuranceUseCase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(ConfirmInsuranceLoaded(message: data.message));
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
