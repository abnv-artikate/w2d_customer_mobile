part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class SendOtpSuccess extends AuthState {
  final String message;

  SendOtpSuccess(this.message);
}

final class VerifyOtpSuccess extends AuthState {
  final UserEntity userEntity;

  VerifyOtpSuccess(this.userEntity);
}

final class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}
