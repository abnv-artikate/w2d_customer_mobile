import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w2d_customer_mobile/core/error/failure.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  AuthCubit({required this.sendOtpUseCase, required this.verifyOtpUseCase})
    : super(AuthInitial());

  sendOtp(SendOtpParams params) async {
    emit(AuthLoading());
    final result = await sendOtpUseCase(params);
    result.fold((l) => _emitFailure(l), (data) {
      emit(SendOtpSuccess(data));
    });
  }

  verifyOtp(VerifyOtpParams params) async {
    emit(AuthLoading());
    final result = await verifyOtpUseCase(params);
    result.fold((l) => _emitFailure(l), (data) {
      emit(VerifyOtpSuccess(data));
    });
  }

  FutureOr<void> _emitFailure(Failure failure) async {
    if (failure is ServerFailure) {
      emit(AuthError(failure.message));
    } else if (failure is CacheFailure) {
      emit(AuthError(failure.message));
    } else {
      emit(AuthError(failure.message));
    }
  }
}
