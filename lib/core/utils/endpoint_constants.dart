// ignore_for_file: constant_identifier_names

class EndPoints {
  /// Customer Endpoints
  static const String createCustomer = '/customer/create/';
  static const String sendOtp = '/customer/send-otp';
  static const String verifyOtp = '/customer/verify-otp/';
  static const String tokenRefresh = '/customer/token/refresh/';

  /// categories Endpoints
  static const String categories = '/categories/';
  static const String categoriesHierarchy = '/categories/hierarchy/';

  /// Product Endpoints
  static const String productView = '/product/view/';
}
