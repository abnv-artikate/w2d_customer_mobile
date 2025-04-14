part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class SendOtpSuccess extends AuthState {
  final String message;

  SendOtpSuccess(this.message);
}

final class SendOtpError extends AuthState {
  final String error;

  SendOtpError(this.error);
}

final class VerifyOtpSuccess extends AuthState {
  final String message;

  VerifyOtpSuccess(this.message);
}

final class VerifyOtpError extends AuthState {
  final String error;

  VerifyOtpError(this.error);
}
