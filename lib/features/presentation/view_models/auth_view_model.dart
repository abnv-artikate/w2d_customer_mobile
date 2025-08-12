import 'package:w2d_customer_mobile/core/base/base_view_model.dart';
import 'package:w2d_customer_mobile/features/domain/entities/user_entity.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/send_otp_usecase.dart';
import 'package:w2d_customer_mobile/features/domain/usecases/auth/verify_otp_usecase.dart';

class AuthViewModel extends BaseViewModel {
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;

  UserEntity? _user;
  String? _otpResponse;
  bool _isOtpSent = false;
  bool _isOtpVerified = false;

  AuthViewModel({
    required SendOtpUseCase sendOtpUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
  }) : _sendOtpUseCase = sendOtpUseCase,
       _verifyOtpUseCase = verifyOtpUseCase;

  UserEntity? get user => _user;

  String? get otpResponse => _otpResponse;

  bool get isOtpSent => _isOtpSent;

  bool get isOtpVerified => _isOtpVerified;

  Future<bool> sendOtp(SendOtpParams params) async {
    final result = await executeWithHandling<String>(() async {
      final result = await _sendOtpUseCase(params);
      return result.fold(
        (failure) => throw Exception(failure.message),
        (data) => data,
      );
    });

    if (result != null) {
      _otpResponse = result;
      _isOtpSent = true;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> verifyOtp(VerifyOtpParams params) async {
    final result = await executeWithHandling<UserEntity>(() async {
      final result = await _verifyOtpUseCase(params);
      return result.fold(
        (failure) => throw Exception(failure.message),
        (data) => data,
      );
    });

    if (result != null) {
      _user = result;
      _isOtpSent = true;
      notifyListeners();
      return true;
    }

    return false;
  }

  void resetAuthState() {
    _user = null;
    _otpResponse = null;
    _isOtpSent = false;
    _isOtpVerified = false;
    clearError();
    notifyListeners();
  }

  void clearOtpState() {
    _otpResponse = null;
    _isOtpSent = false;
    _isOtpVerified = false;
    clearError();
    notifyListeners();
  }
}
