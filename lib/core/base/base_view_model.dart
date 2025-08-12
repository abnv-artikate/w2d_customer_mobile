import 'package:flutter/foundation.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isDisposed = false;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    if (_isDisposed) return;
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    if (_isDisposed) return;
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    if (_isDisposed) return;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<T?> executeWithHandling<T>(
    Future<T> Function() operation, {
    bool showLoading = true,
    bool clearErrorFirst = true,
  }) async {
    if (clearErrorFirst) clearError();
    if (showLoading) setLoading(true);

    try {
      final result = await operation();
      return result;
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      if (showLoading) setLoading(false);
    }
  }
}
