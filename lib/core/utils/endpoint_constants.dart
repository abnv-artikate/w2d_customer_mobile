// ignore_for_file: constant_identifier_names

class EndPoints {
  /// Customer Endpoints
  static const String createCustomer = '/customer/create/';
  static const String sendOtp = '/customer/send-otp';
  static const String verifyOtp = '/customer/verify-otp/';
  static const String tokenRefresh = '/customer/token/refresh/';

  /// Categories Endpoints
  static const String categories = '/categories/';
  static const String categoriesHierarchy = '/categories/hierarchy/';

  /// Collections Endpoints
  static const String collectionsGetByName = '/collections/get-by-name/';

  /// Product Endpoints
  static const String productView = '/product/view';

  /// Cart Sync Endpoint
  static const String cartSync = '/cart-sync/';
}
